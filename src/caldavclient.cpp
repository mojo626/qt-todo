#include "caldavclient.h"
#include <QDebug>
#include "dotenv.h"
#include "caldav/calendar.h"
#include "caldav/client.h"
#include "caldav/todo.h"
#include <vector>
#include <QVariantList>
#include <QVariantMap>
#include <QDateTime>

CaldavClient::CaldavClient(QObject *parent) : QObject(parent), env("../.env") {
    user_pass = "ben:" + env.get("PASSWORD");

}

QVariantList CaldavClient::getTodos() {  
    

	caldav::Client client("https://calendar.benjaynes.com", user_pass);

	std::vector<caldav::Calendar> calendars = client.GetCalendars();

    std::vector<caldav::Todo> todos = client.GetTodos(calendars[1]);

    QVariantList list;

    for (const auto& todo : todos) {
        QVariantMap item;

        item["summary"] = QString::fromStdString(todo.summary);
        item["uid"] = QString::fromStdString(todo.uid);
        item["percent_completed"] = todo.percent_completed;
        item["status"] = todo.status == caldav::TodoStatus::COMPLETED;
        std::cout << todo.created << std::endl;
        item["created"] = QDateTime::fromString(QString::fromStdString(todo.created), "yyyyMMddThhmmssZ");

        list.append(item);
    }

    return list;
}
