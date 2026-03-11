#pragma once

#include <QObject>
#include <QVariantList>
#include <QtCore/qcontainerfwd.h>
#include <QtCore/qtmetamacros.h>
#include "caldav/client.h"
#include "dotenv.h"

class CaldavClient : public QObject {

    Q_OBJECT
    public:
        explicit CaldavClient(QObject *parent = 0);
        Q_INVOKABLE QVariantList getTodos(int cal_id);
        Q_INVOKABLE QVariantList getCalendars();
    
    private:
        dotenv env;
        caldav::Client client;
        std::string user_pass;


};