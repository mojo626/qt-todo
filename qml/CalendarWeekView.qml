import QtQuick
import QtQml
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient
import QtQuick.Controls.FluentWinUI3

Rectangle {
    id: monthView

    color: palette.base

    ScrollView {
        anchors.fill: parent

        ListView {
            id: dayList

            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height * 2

            model: dayModel

            orientation: ListView.Horizontal

            snapMode: ListView.SnapOneItem

            clip: true

            onCountChanged: {
                if (count > 0) {
                    positionViewAtIndex(Math.floor(count / 2), ListView.Center);
                    dayList.currentIndex = Math.floor(count / 2);
                }
            }

            delegate: Rectangle {
                color: palette.base

                width: dayList.width / 7
                height: dayList.height

                border.width: 0.5
                border.color: palette.button


                ColumnLayout {
                    id: day_column

                    anchors.fill: parent

                    property var events

                    spacing: 10

                    property var dayDate: model.startDate

                    Text {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 10

                        Layout.margins: 5

                        horizontalAlignment: Text.AlignLeft
                        
                        //opacity: model.month === control.month ? 1 : 0.5
                        text: day_column.dayDate.getDate() + (day_column.dayDate.getDate() == 1 ? "  " + Qt.formatDate(day_column.dayDate, "MMMM") : "")
                        color: palette.text


                    }

                    function convertTZ(date, tzString) {
                        return new Date(date.toUTCString());  
                    }

                    Component.onCompleted: {
                        var endOfDay = day_column.dayDate;
                        endOfDay.setHours(23);
                        endOfDay.setMinutes(59);
                        day_column.events = calendarUtil.getEventsInRange(day_column.dayDate, endOfDay);
                        
                    } 

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

                            RowLayout {
                                id: eventLayout

                                property int indexOfThisDelegate: index

                                property var event_summary: modelData.summary
                                property var calendar_id: modelData.calendar_id

                                visible: indexOfThisDelegate < eventsListView.shownEvents

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
                }
            }
        }
    }

    

    
}