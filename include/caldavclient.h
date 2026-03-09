#pragma once

#include <QObject>
#include "dotenv.h"

class CaldavClient : public QObject {

    Q_OBJECT
    public:
        explicit CaldavClient(QObject *parent = 0);
        Q_INVOKABLE QString getTodos();
    
    private:
        dotenv env;
        std::string user_pass;

};