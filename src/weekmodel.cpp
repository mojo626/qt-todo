#include "weekmodel.h"
#include <qabstractitemmodel.h>
#include <qdatetime.h>

QVariant WeekModel::data(const QModelIndex &index, int role) const {
    if (role == StartDateRole)
        return weeks[index.row()];
    return {};
}

int WeekModel::rowCount(const QModelIndex &) const {
    return weeks.size();
}

void WeekModel::generateWeeks(QDate centerDate, int count) {
    weeks.clear();

    QDate start = centerDate.addDays(-centerDate.dayOfWeek() + 1);

    for (int i = -count/2; i < count/2; i++) {
        weeks.push_back(start.addDays(i * 7));
    }

    beginResetModel();
    endResetModel();
}

QHash<int, QByteArray> WeekModel::roleNames() const {
  QHash<int, QByteArray> roles;
  roles[StartDateRole] = "startDate";
  return roles;
}