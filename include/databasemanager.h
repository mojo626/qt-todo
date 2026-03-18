#pragma once

#include <QSqlDatabase>
#include <QDateTime>


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

        QList<QVariantMap> getEventsInRange(QDateTime start, QDateTime end);

    private:
        DatabaseManager() = default;
        QSqlDatabase db;
};