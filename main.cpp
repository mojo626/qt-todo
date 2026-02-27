
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QtQuick>
#include <QQmlContext>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
	engine.addImportPath("lib/MMaterial");
	engine.load(QUrl(QStringLiteral("rc:/main.qml")));
    if(engine.rootObjects().isEmpty())
        return EXIT_FAILURE;

    return app.exec();
}
