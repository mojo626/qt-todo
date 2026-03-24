import QtQuick
import QtQml
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient
import QtQuick.Controls.FluentWinUI3

Row {
    id: weekRow
    

    property var weekStart: model.startDate

    
    spacing: 0

    Repeater {
        model: 7

        Rectangle {
            width: weekRow.width / 7
            height: weekRow.height

            color: palette.base

            border.width: 0.5
            border.color: palette.button

            property date dayDate: new Date(
                weekRow.weekStart.getFullYear(),
                weekRow.weekStart.getMonth(),
                weekRow.weekStart.getDate() + index
            )

            ColumnLayout {
                id: base_day_column

                anchors.fill: parent

                property var events

                spacing: 10

                Text {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 10

                    Layout.margins: 5

                    horizontalAlignment: Text.AlignLeft
                    
                    //opacity: model.month === control.month ? 1 : 0.5
                    text: dayDate.getDate() + (dayDate.getDate() == 1 ? "  " + Qt.formatDate(dayDate, "MMMM") : "")
                    color: palette.text


                }

                function convertTZ(date, tzString) {
                    return new Date(date.toUTCString());  
                }

                Component.onCompleted: {
                    var endOfDay = dayDate;
                    endOfDay.setHours(23);
                    endOfDay.setMinutes(59);
                    base_day_column.events = calendarUtil.getEventsInRange(dayDate, endOfDay);
                    
                } 

                MonthViewEvents {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    events: base_day_column.events
                }

            }
        }
    }
}