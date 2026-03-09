#include "caldavclient.h"
#include <QDebug>
#include "dotenv.h"
#include "caldav/calendar.h"
#include "caldav/client.h"
#include "caldav/todo.h"
#include <vector>
#include <QVariantList>
#include <QVariantMap>

CaldavClient::CaldavClient(QObject *parent) : QObject(parent), env("../.env") {
    user_pass = "ben:" + env.get("PASSWORD");

}

QVariantList CaldavClient::getTodos() {  
    

	caldav::Client client("https://calendar.benjaynes.com", user_pass);

	std::vector<caldav::Calendar> calendars = client.GetCalendars();

    std::vector<caldav::Todo> todos = client.GetTodos(calendars[0]);

    QVariantList list;

    for (const auto& todo : todos) {
        QVariantMap item;

        item["summary"] = QString::fromStdString(todo.summary);

        list.append(item);
    }

    return list;
}
