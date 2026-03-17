import QtQuick
import QtQml
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient
import QtQuick.Controls.FluentWinUI3

Rectangle {
    id: mainView

    color: palette.base

    property int calendar: 0

    // MonthGrid {
    //     id: control

    //     anchors.fill: parent

    //     month: Calendar.March
    //     year: 2026
    //     locale: Qt.locale("en_US")

    //     spacing: 0
        
    //     delegate: Rectangle {
    //         border.width: 0.5
    //         border.color: palette.button

    //         color: palette.base

    //         ColumnLayout {
    //             anchors.fill: parent

    //             Text {
    //                 Layout.fillWidth: true
    //                 Layout.preferredHeight: 10

    //                 Layout.margins: 5

    //                 horizontalAlignment: Text.AlignRight
                    
    //                 opacity: model.month === control.month ? 1 : 0.5
    //                 text: model.day
    //                 color: palette.text


    //             }

    //             Item {
    //                 Layout.fillHeight: true
    //                 Layout.fillWidth: true
    //             }

    //         }

            
    //     }
        
    // }
    property var events: client.getEvents(0)
    

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

            height: 120
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
                        anchors.fill: parent

                        Text {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 10

                            Layout.margins: 5

                            horizontalAlignment: Text.AlignLeft
                            
                            //opacity: model.month === control.month ? 1 : 0.5
                            text: dayDate.getDate() + (dayDate.getDate() == 1 ? "  " + Qt.formatDate(dayDate, "MMMM") : "")
                            color: palette.text


                        }

                        Label {
                            property var test: "hi"

                            text: test

                            Component.onCompleted: {
                                for (var i = 0; i < events.length; i++) {
                                    if (events[i].dtstart.getDate() == dayDate.getDate() && events[i].dtstart.getYear() == dayDate.getYear() && events[i].dtstart.getMonth() == dayDate.getMonth()) {
                                        test = events[i].summary;
                                    }
                                }
                            }
                        }

                        Item {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                        }

                    }
                }
            }
        }
    }

    
}