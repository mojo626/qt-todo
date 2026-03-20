#include "databasemanager.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QtCore/qdatetime.h>
#include <QtCore/qtimezone.h>
#include <qcontainerfwd.h>
#include <qdatetime.h>
#include <qlist.h>
#include <qlogging.h>
#include <qnamespace.h>
#include <qsqldatabase.h>
#include <qsqlquery.h>
#include <iostream>
#include <string>

DatabaseManager& DatabaseManager::instance() {
    static DatabaseManager instance;
    return instance;
}

bool DatabaseManager::open(const QString& path) {
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(path);

    if (!db.open()) {
        std::cout << "DB open error: " << db.lastError().text().toStdString() << std::endl;
        return false;
    }

    return true;
}

void DatabaseManager::init() {
    QSqlQuery query;

    query.exec(R"(
        CREATE TABLE IF NOT EXISTS events (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            uid TEXT,
            calendar_id TEXT,
            etag TEXT,
            summary TEXT,
            start_time TEXT,
            end_time TEXT,
            timezone TEXT,
            UNIQUE(uid, calendar_id)
        )
    )");

    query.exec(R"(
        CREATE TABLE IF NOT EXISTS calendars (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            display_name TEXT,
            calendar_id TEXT,
            ctag TEXT,
            color TEXT,
            UNIQUE(calendar_id)
        )
    )");

    query.exec(R"(
        CREATE INDEX IF NOT EXISTS idx_events_time
        ON events(start_time, end_time)    
    )");
}

bool DatabaseManager::upsertEvent(
    const QString& uid,
    const QString& calendarId,
    const QString& etag,
    const QString& summary,
    const QDateTime& start,
    const QDateTime& end,
    const QString& timezone
) {
    QSqlQuery query;

    query.prepare(R"(
        INSERT INTO events (uid, calendar_id, etag, summary, start_time, end_time, timezone)
        VALUES (?, ?, ?, ?, ?, ?, ?)
        ON CONFLICT(uid, calendar_id) DO UPDATE SET
            etag=excluded.etag,
            summary=excluded.summary,
            start_time=excluded.start_time,
            end_time=excluded.end_time,
            timezone=excluded.timezone    
    )");

    query.addBindValue(uid);
    query.addBindValue(calendarId);
    query.addBindValue(etag);
    query.addBindValue(summary);
    query.addBindValue(start.toUTC().toString(Qt::ISODate));
    query.addBindValue(end.toUTC().toString(Qt::ISODate));
    query.addBindValue(timezone);

    if (!query.exec()) {
        std::cout << "Upsert error: " << db.lastError().text().toStdString() << std::endl;
        return false;
    }

    return true;
}

bool DatabaseManager::upsertCalendar(
    const QString& display_name,
    const QString& calendar_id,
    const QString& ctag,
    const QString& color
) {
    QSqlQuery query;

    query.prepare(R"(
        INSERT INTO calendars (display_name, calendar_id, ctag, color)
        VALUES (?, ?, ?, ?)
        ON CONFLICT(calendar_id) DO UPDATE SET
            display_name=excluded.display_name,
            ctag=excluded.ctag,
            color=excluded.color   
    )");

    query.addBindValue(display_name);
    query.addBindValue(calendar_id);
    query.addBindValue(ctag);
    query.addBindValue(color);

    if (!query.exec()) {
        std::cout << "Upsert error: " << db.lastError().text().toStdString() << std::endl;
        return false;
    }

    return true;
}

QList<QVariantMap> DatabaseManager::getEventsInRange(QDateTime start, QDateTime end) {
    QList<QVariantMap> results;

    QSqlQuery query;

    //std::cout << start.toTimeZone(start.timeZone()).toString(Qt::ISODate).toStdString() << std::endl;

    query.prepare(R"(
        SELECT uid, summary, start_time, end_time, timezone, calendar_id
        FROM events
        WHERE end_time >= ? AND start_time <= ?    
    )");

    query.addBindValue(start.toUTC().toString(Qt::ISODate));
    query.addBindValue(end.toUTC().toString(Qt::ISODate));

    if (!query.exec()) {
        std::cout << "Query error: " << db.lastError().text().toStdString() << std::endl;
        return results;
    }

    while (query.next()) {
        QVariantMap event;

        event["uid"] = query.value(0);
        event["summary"] = query.value(1);
        event["start"] = QDateTime::fromString(query.value(2).toString(), Qt::ISODate);
        event["end"] = QDateTime::fromString(query.value(3).toString(), Qt::ISODate);
        event["timezone"] = query.value(4);
        event["calendar_id"] = query.value(5);

        results.append(event);
    }

    return results;
}

QVariantMap DatabaseManager::getCalendar(int calendar_id) {
    QVariantMap result; 

    QSqlQuery query;

    query.prepare(R"(
        SELECT display_name, calendar_id, ctag, color
        FROM calendars
        WHERE calendar_id == ? 
    )");

    query.addBindValue(QString::fromStdString(std::to_string(calendar_id)));

    if (!query.exec()) {
        std::cout << "Query error: " << db.lastError().text().toStdString() << std::endl;
        return result;
    }

    while (query.next()) {
        result["display_name"] = query.value(0);
        result["calendar_id"] = query.value(1);
        result["ctag"] = query.value(2);
        result["color"] = query.value(3);
    }

    return result;
}