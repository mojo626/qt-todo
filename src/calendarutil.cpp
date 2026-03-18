#include "calendarutil.h"
#include <QtCore/qcontainerfwd.h>
#include <QtCore/qstring.h>
#include <iostream>
#include <qdatetime.h>
#include "databasemanager.h"
#include "date/iso_week.h"

QList<QVariantMap> CalendarUtil::getEventsInRange(QDateTime start, QDateTime end) {
    return DatabaseManager::instance().getEventsInRange(start, end);
}