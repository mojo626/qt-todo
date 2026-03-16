#pragma once

#include <QObject>
#include <QtCore/qtmetamacros.h>
#include <ctime>

class CalendarUtil : public QObject {

    Q_OBJECT
    public:
        Q_INVOKABLE int testing();
};