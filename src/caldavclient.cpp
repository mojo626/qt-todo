#include "caldavclient.h"
#include <QDebug>
#include "dotenv.h"
#include "caldav/calendar.h"
#include "caldav/client.h"
#include "caldav/todo.h"
#include <vector>

CaldavClient::CaldavClient(QObject *parent) : QObject(parent), env("../.env") {
    user_pass = "ben:" + env.get("PASSWORD");

}

QString CaldavClient::getTodos() {  
    

	caldav::Client client("https://calendar.benjaynes.com", user_pass);

	std::vector<caldav::Calendar> calendars = client.GetCalendars();

    std::vector<caldav::Todo> todos = client.GetTodos(calendars[0]);

    
    
    for (caldav::Todo todo : todos) {
        std::cout << todo.completed << std::endl;
        
        
    }

    return "Hello";
}
