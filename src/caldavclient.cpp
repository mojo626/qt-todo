#include "caldavclient.h"
#include <QDebug>
#include "dotenv.h"

CaldavClient::CaldavClient(QObject *parent) : QObject(parent) {
    qDebug() << "testing";
}

void CaldavClient::printMessage(QString txt) {  
    qDebug() << "Message from QML: " << txt;
}