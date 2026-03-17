#pragma once

#include <QObject>
#include <QtCore/qcontainerfwd.h>
#include <QtCore/qstring.h>
#include <QtCore/qtmetamacros.h>
#include <ctime>

class CalendarUtil : public QObject {

    Q_OBJECT
    public:
        Q_INVOKABLE void getListOfWeeks();
};