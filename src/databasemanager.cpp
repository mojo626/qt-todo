#include "databasemanager.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <qcontainerfwd.h>
#include <qdatetime.h>
#include <qlist.h>
#include <qlogging.h>
#include <qnamespace.h>
#include <qsqldatabase.h>
#include <qsqlquery.h>

DatabaseManager& DatabaseManager::instance() {
    static DatabaseManager instance;
    return instance;
}

bool DatabaseManager::open(const QString& path) {
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(path);

    if (!db.open()) {
        qDebug() << "DB open error: " << db.lastError();
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
            etag=excluded.etag
            summary=excluded.summary
            start_time=excluded.start_time
            end_time=excluded.end_time
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
        qDebug() << "Upsert error: " << query.lastError();
        return false;
    }

    return true;
}

QList<QVariantMap> DatabaseManager::getEventsInRange(QDateTime start, QDateTime end) {
    QList<QVariantMap> results;

    QSqlQuery query;

    query.prepare(R"(
        SELECT uid, summary, start_time, end_time, timezone
        FROM events
        WHERE end_time >= ? AND start_time <= ?    
    )");

    query.addBindValue(start.toUTC().toString(Qt::ISODate));
    query.addBindValue(end.toUTC().toString(Qt::ISODate));

    if (!query.exec()) {
        qDebug() << "Query error: " << query.lastError();
        return results;
    }

    while (query.next()) {
        QVariantMap event;

        event["uid"] = query.value(0);
        event["summary"] = query.value(1);
        event["start"] = QDateTime::fromString(query.value(2).toString(), Qt::ISODate);
        event["end"] = QDateTime::fromString(query.value(3).toString(), Qt::ISODate);
        event["timezone"] = query.value(4);

        results.append(event);
    }

    return results;
}