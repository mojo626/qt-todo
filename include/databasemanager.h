#pragma once

#include <QSqlDatabase>
#include <QDateTime>
#include <qcontainerfwd.h>


class DatabaseManager {
    public:
        static DatabaseManager& instance();

        bool open(const QString& path);
        void init();

        bool upsertEvent(
            const QString& uid,
            const QString& calendarId,
            const QString& etag,
            const QString& summary,
            const QDateTime& start,
            const QDateTime& end,
            const QString& timezone
        );

        bool upsertCalendar(
            const QString& display_name,
            const QString& calendar_id,
            const QString& ctag,
            const QString& color
        );

        QList<QVariantMap> getEventsInRange(QDateTime start, QDateTime end);
        QVariantMap getCalendar(int calendar_id);

    private:
        DatabaseManager() = default;
        QSqlDatabase db;
};