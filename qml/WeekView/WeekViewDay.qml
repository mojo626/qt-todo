import QtQuick
import QtQml
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient
import QtQuick.Controls.FluentWinUI3

Rectangle {
    id: dayRect

    color: "transparent"

    

    border.width: 0.5
    border.color: palette.button

    property var date


    ColumnLayout {
        id: day_column

        anchors.fill: parent

        property var events

        spacing: 10

        property var dayDate: dayRect.date


        function convertTZ(date, tzString) {
            return new Date(date.toUTCString());  
        }

        Component.onCompleted: {
            var endOfDay = day_column.dayDate;
            endOfDay.setHours(23);
            endOfDay.setMinutes(59);
            var startOfDay = day_column.dayDate;
            startOfDay.setHours(0);
            startOfDay.setMinutes(0);
            day_column.events = calendarUtil.getEventsInRange(startOfDay, endOfDay);
            
        } 

        ListView {
            id: eventsListView

            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 5
            model: day_column.events

            interactive: false

            clip: true


            delegate: Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right

                //anchors.top: parent.top
                //anchors.topMargin: event.start.getHours() * weekView.hourHeight

                property var event: modelData


                height: (event.end.getHours() - event.start.getHours()) * weekView.hourHeight

                color: "#000000"

                Label {
                    color: "#FFFFFF"
                    text: event.summary
                }
               
                
            }
        }
    }
}