#include "daymodel.h"
#include <qabstractitemmodel.h>
#include <qdatetime.h>

QVariant DayModel::data(const QModelIndex &index, int role) const {
    if (role == StartDateRole)
        return days[index.row()];
    return {};
}

int DayModel::rowCount(const QModelIndex &) const {
    return days.size();
}

void DayModel::generateDays(QDate centerDate, int count) {
    days.clear();

    QDate start = centerDate;

    for (int i = -count/2; i < count/2; i++) {
        days.push_back(start.addDays(i));
    }

    beginResetModel();
    endResetModel();
}

QHash<int, QByteArray> DayModel::roleNames() const {
  QHash<int, QByteArray> roles;
  roles[StartDateRole] = "startDate";
  return roles;
}