#include "caldavclient.h"
#include <QDebug>
#include "caldav/event.h"
#include "databasemanager.h"
#include "dotenv.h"
#include "caldav/calendar.h"
#include "caldav/client.h"
#include "caldav/todo.h"
#include "ical.h"
#include "icaltime.h"
#include <QtCore/qcontainerfwd.h>
#include <qtimezone.h>
#include <vector>
#include <QVariantList>
#include <QVariantMap>
#include <QDateTime>

CaldavClient::CaldavClient(QObject *parent) : QObject(parent), env("../.env"), client(env.get("CALENDAR_URL"),"ben:" + env.get("PASSWORD")) {
    getEvents(0);
}

QDateTime CaldavClient::toQDateTime(icaltimetype t) {
    if (icaltime_is_null_time(t))
        return QDateTime();

    QDate date(t.year, t.month, t.day);

    // All-day event
    if (icaltime_is_date(t)) {
        return QDateTime(date, QTime(0, 0), QTimeZone::LocalTime);
    }

    QTime time(t.hour, t.minute, t.second);

    // UTC time
    if (icaltime_is_utc(t)) {
        return QDateTime(date, time, QTimeZone::UTC);
    }

    // Time with timezone
    if (t.zone != nullptr) {
        const char *tzid = icaltimezone_get_tzid((icaltimezone *)t.zone);

        if (tzid) {
            QTimeZone tz(tzid);  // expects IANA tzid

            if (tz.isValid()) {
                return QDateTime(date, time, tz);
            }
        }
    }

    // Floating time (no timezone)
    return QDateTime(date, time, QTimeZone::LocalTime);
}

QVariantList CaldavClient::getTodos(int cal_id) {  

	std::vector<caldav::Calendar> calendars = client.GetCalendars();

    std::vector<caldav::Todo> todos = client.GetTodos(calendars[cal_id]);

    QVariantList list;

    for (const auto& todo : todos) {
        QVariantMap item;

        item["summary"] = QString::fromStdString(todo.summary);
        item["uid"] = QString::fromStdString(todo.uid);
        item["percent_completed"] = todo.percent_completed;
        item["status"] = todo.status == caldav::TodoStatus::COMPLETED;
        item["created"] = QDateTime::fromString(QString::fromStdString(todo.created), "yyyyMMddThhmmssZ");

        list.append(item);
    }

    return list;
}

QVariantList CaldavClient::getEvents(int cal_id) {  

	std::vector<caldav::Calendar> calendars = client.GetCalendars();

    std::vector<caldav::Event> events = client.GetEvents(calendars[cal_id]);

    QVariantList list;

    auto& db = DatabaseManager::instance();

    for (const auto& event : events) {
        QVariantMap item;

        QDateTime dtstart;
        dtstart.setSecsSinceEpoch(icaltime_as_timet(icaltime_convert_to_zone(event.dtstart, icaltimezone_get_utc_timezone())));

        QDateTime dtend;
        dtend.setSecsSinceEpoch(icaltime_as_timet(icaltime_convert_to_zone(event.dtend, icaltimezone_get_utc_timezone())));

        std::cout << db.upsertEvent(
            QString::fromStdString(event.uid), 
            QString::fromStdString(std::to_string(cal_id)), 
            QString::fromStdString(event.etag), 
            QString::fromStdString(event.summary), 
            dtstart,
            dtend, 
            QString::fromStdString("UTC")
        ) << std::endl;

        item["dtstart"] = toQDateTime(event.dtstart);
        item["dtend"] = toQDateTime(event.dtend);
        item["dtstamp"] = toQDateTime(event.dtstamp);
        item["summary"] = QString::fromStdString(event.summary);
        item["uid"] = QString::fromStdString(event.uid);

        list.append(item);
    }

    return list;
}

QVariantList CaldavClient::getCalendars() {

    std::vector<caldav::Calendar> calendars = client.GetCalendars();

    QVariantList list;

    for (const auto& calendar : calendars) {
        QVariantMap item;

        item["display_name"] = QString::fromStdString(calendar.display_name);
        item["color"] = QString::fromStdString(calendar.color);
        item["id"] = list.size();

        list.append(item);

        std::cout << calendar.color << std::endl;
    }

    return list;
}
