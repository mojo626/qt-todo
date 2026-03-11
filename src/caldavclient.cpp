#include "caldavclient.h"
#include <QDebug>
#include "dotenv.h"
#include "caldav/calendar.h"
#include "caldav/client.h"
#include "caldav/todo.h"
#include <QtCore/qcontainerfwd.h>
#include <vector>
#include <QVariantList>
#include <QVariantMap>
#include <QDateTime>

CaldavClient::CaldavClient(QObject *parent) : QObject(parent), env("../.env"), client("https://calendar.benjaynes.com","ben:" + env.get("PASSWORD")) {

}


QVariantList CaldavClient::getTodos() {  

	std::vector<caldav::Calendar> calendars = client.GetCalendars();

    std::vector<caldav::Todo> todos = client.GetTodos(calendars[1]);

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

QVariantList CaldavClient::getCalendars() {

    std::vector<caldav::Calendar> calendars = client.GetCalendars();

    QVariantList list;

    for (const auto& calendar : calendars) {
        QVariantMap item;

        item["display_name"] = QString::fromStdString(calendar.display_name);
        item["color"] = QString::fromStdString(calendar.color);

        list.append(item);

        std::cout << calendar.color << std::endl;
    }

    return list;
}
