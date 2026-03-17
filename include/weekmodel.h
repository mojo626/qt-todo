#pragma once

#include <qabstractitemmodel.h>
#include <qdatetime.h>

class WeekModel : public QAbstractListModel {
    
    Q_OBJECT
    public:
        enum Roles {
            StartDateRole = Qt::UserRole
        };

        QVariant data(const QModelIndex &index, int role) const override;
        int rowCount(const QModelIndex &) const override;
        void generateWeeks(QDate centerDate, int count = 200);

    private:
        QVector<QDate> weeks;
    
    protected:
        QHash<int, QByteArray> roleNames() const;
};