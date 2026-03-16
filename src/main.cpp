#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QtQuick>
#include <QQmlContext>
#include <iostream>
#include <QtQuickControls2/QQuickStyle>
#include <QProcess>
#include <QPalette>
#include <QColor>
#include <vector>
#include "caldavclient.h"
#include "caldav/todo.h"
#include "dotenv.h"

int main(int argc, char *argv[])
{

	QQuickStyle::setStyle("FluentWinUI3");

	QGuiApplication app(argc, argv);


	QPalette darkPalette;
	darkPalette.setColor(QPalette::Window, QColor("#1E1E1E"));
	darkPalette.setColor(QPalette::WindowText, QColor("#FFFFFF"));
	darkPalette.setColor(QPalette::Base, QColor("#121212"));
	darkPalette.setColor(QPalette::AlternateBase, QColor("#1E1E1E"));
	darkPalette.setColor(QPalette::ToolTipBase, QColor("#FFFFFF"));
	darkPalette.setColor(QPalette::ToolTipText, QColor("#FFFFFF"));
	darkPalette.setColor(QPalette::Text, QColor("#FFFFFF"));
	darkPalette.setColor(QPalette::Button, QColor("#2D2D30"));
	darkPalette.setColor(QPalette::ButtonText, QColor("#FFFFFF"));
	darkPalette.setColor(QPalette::BrightText, QColor("#FF0000"));
	darkPalette.setColor(QPalette::Highlight, QColor("#0078D7"));
	darkPalette.setColor(QPalette::HighlightedText, QColor("#FFFFFF"));
	app.setPalette(darkPalette);


	qmlRegisterType<CaldavClient>("CaldavClient", 1, 0, "CaldavClient");

    QQmlApplicationEngine engine;
	
	QObject::connect(
			&engine,
			&QQmlApplicationEngine::objectCreationFailed,
			&app,
			[]() { QCoreApplication::exit(-1); },
			Qt::QueuedConnection);

	engine.loadFromModule("frontend", "Main");


    return app.exec();
}
