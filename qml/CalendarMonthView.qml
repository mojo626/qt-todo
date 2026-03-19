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

    property var eventlist: client.getCalendars().length
    

    ListView {
        id: weekList

        anchors.fill: parent

        model: weekModel

        orientation: ListView.Vertical

        interactive: false

        snapMode: ListView.SnapOneItem
        //highlightRangeMode: ListView.StrictlyEnforceRange

        onCountChanged: {
            if (count > 0) {
                positionViewAtIndex(Math.floor(count / 2), ListView.Contain);
                weekList.currentIndex = Math.floor(count / 2);
            }
        }

        MouseArea {
            acceptedButtons: Qt.NoButton // we handle manually

            anchors.fill: parent

            onWheel: (event) => {
                if (event.angleDelta.y > 0) {
                    weekList.currentIndex = Math.max(0, weekList.currentIndex - 1)
                } else if (event.angleDelta.y < 0) {
                    weekList.currentIndex = Math.min(weekList.count - 1, weekList.currentIndex + 1)
                }

                weekList.positionViewAtIndex(
                    weekList.currentIndex,
                    ListView.Contain
                )
                console.log(event.angleDelta.y);

                event.accepted = true
            }
        }

        delegate: Row {
            id: weekRow
            

            property var weekStart: model.startDate

            height: mainView.height / 6
            width: ListView.view.width
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
                        id: day_column

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

                        Component.onCompleted: {
                            var endOfDay = dayDate;
                            endOfDay.setHours(23);
                            endOfDay.setMinutes(59);
                            day_column.events = calendarUtil.getEventsInRange(dayDate, endOfDay);
                            
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

                            delegate: RowLayout {
                                id: eventLayout

                                property int indexOfThisDelegate: index

                                property var event_summary: modelData.summary
                                property var calendar_id: modelData.calendar_id

                                visible: indexOfThisDelegate < eventsListView.shownEvents

                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.margins: 5
                                height: eventsListView.eventHeight
                            

                                Rectangle {
                                    color: calendarUtil.getCalendar(eventLayout.calendar_id).color.substring(0, 7)
                                    Layout.fillHeight: true
                                    Layout.preferredWidth: 10
                                    radius: 5
                                }

                                Rectangle {
                                    id: eventRect

                                    color: palette.base

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

                        Label {
                            visible: eventsListView.extraEvents != 0

                            text: "+" + eventsListView.extraEvents

                            Layout.margins: 5
                        }

                    }
                }
            }
        }
    }

    
}