#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QtQuick>
#include <QQmlContext>
#include <iostream>
#include <QtQuickControls2/QQuickStyle>
#include <vector>
#include "caldavclient.h"
#include "caldav/todo.h"
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

	std::cout << "hi" << std::endl;


    return app.exec();
}
