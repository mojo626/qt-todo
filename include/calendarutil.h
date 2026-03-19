#pragma once

#include <QObject>
#include <QtCore/qcontainerfwd.h>
#include <QtCore/qstring.h>
#include <QtCore/qtmetamacros.h>
#include <ctime>

class CalendarUtil : public QObject {

    Q_OBJECT
    public:
        Q_INVOKABLE QList<QVariantMap> getEventsInRange(QDateTime start, QDateTime end);
        Q_INVOKABLE QVariantMap getCalendar(int calendar_id);
};