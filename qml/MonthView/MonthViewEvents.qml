import QtQuick
import QtQml
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient
import QtQuick.Controls.FluentWinUI3

ColumnLayout {
    id: day_column

    property var events

    ListView {
        id: eventsListView

        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: 5

        model: day_column.events

        interactive: false

        clip: true

        property var eventHeight: 20
        property var extraEvents: 0
        property var shownEvents: day_column.events.length

        function updateShownEvents() {
            if (!day_column.events) {
                return;
            }

        
            var spacing = eventsListView.spacing
            var totalHeight = eventsListView.height
            var eventHeight = eventsListView.eventHeight
            var totalEvents = day_column.events.length

            var maxEvents = Math.floor(
                (totalHeight + spacing) / (eventHeight + spacing)
            )

            eventsListView.shownEvents = Math.min(maxEvents, totalEvents)
            eventsListView.extraEvents = Math.max(0, totalEvents - maxEvents)
        }

        Component.onCompleted: {
            updateShownEvents();
        
        }

        onHeightChanged: {
            updateShownEvents();
        }

        delegate: Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right

            height: eventsListView.eventHeight

            //color: calendarUtil.getCalendar(modelData.calendar_id).color.substring(0, 7)
            color: "transparent"

            visible: index < eventsListView.shownEvents

            RowLayout {
                id: eventLayout

                property var event_summary: modelData.summary
                property var calendar_id: modelData.calendar_id

                

                anchors.fill: parent
            

                Rectangle {
                    color: calendarUtil.getCalendar(eventLayout.calendar_id).color.substring(0, 7)
                    Layout.fillHeight: true
                    Layout.preferredWidth: 10
                    radius: 5
                }

                Rectangle {
                    id: eventRect

                    color: "transparent"

                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Label {
                        text: eventLayout.event_summary

                        width: parent.width

                        elide: Text.ElideRight
                    }
                }

                
            }
        }
        
        
        
    }

    Label {
        visible: eventsListView.extraEvents != 0

        text: "+" + eventsListView.extraEvents

        Layout.margins: 5
    }
}
