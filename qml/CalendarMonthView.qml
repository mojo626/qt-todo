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

        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange

        delegate: Row {
            id: weekRow
            

            property var weekStart: model.startDate

            height: mainView.height / 6
            anchors.left: parent.left
            anchors.right: parent.right
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
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 20
                            model: day_column.events

                            interactive: false

                            delegate: RowLayout {
                                id: eventLayout

                                property var test: modelData.summary

                                anchors.left: parent.left
                                anchors.right: parent.right
                                height: 20
                            

                                Rectangle {
                                    color: "#FF0000"
                                    Layout.fillHeight: true
                                    Layout.preferredWidth: 10
                                }

                                Rectangle {
                                    id: eventRect

                                    color: palette.base

                                    Layout.fillHeight: true
                                    Layout.fillWidth: true

                                    Label {
                                        

                                        text: eventLayout.test

                                        
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