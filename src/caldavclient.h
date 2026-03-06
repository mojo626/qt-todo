#ifndef CALDAVCLIENT_H
#define CALDAVCLIENT_H

#include <QObject>

class CaldavClient : public QObject {

    Q_OBJECT
    public:
        explicit CaldavClient(QObject *parent = 0);
        Q_INVOKABLE void printMessage(QString txt);
    


    signals:

    public slots:
};

#endif