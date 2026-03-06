#include "caldav/calendar.h"
#include "caldav/client.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QtQuick>
#include <QQmlContext>
#include <iostream>
#include <QtQuickControls2/QQuickStyle>
#include <vector>
#include "caldavclient.h"
#include "dotenv.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

	qmlRegisterType<CaldavClient>("CaldavClient", 1, 0, "CaldavClient");

	QQuickStyle::setStyle("Imagine");
    QQmlApplicationEngine engine;
	
	QObject::connect(
			&engine,
			&QQmlApplicationEngine::objectCreationFailed,
			&app,
			[]() { QCoreApplication::exit(-1); },
			Qt::QueuedConnection);

	engine.loadFromModule("frontend", "Main");

	dotenv env("../.env");

	std::string user_pass = "ben:" + env.get("PASSWORD");

	caldav::Client client("https://calendar.benjaynes.com", user_pass);

	std::vector<caldav::Calendar> calendars = client.GetCalendars();

	std::cout << calendars[0].display_name << std::endl;

	


    return app.exec();
}
