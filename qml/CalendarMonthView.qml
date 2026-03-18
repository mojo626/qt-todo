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

            Component.onCompleted: {
                console.log(parent.height);
            }

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

                            Connections {

                                target: monthView

                                function onEventlistChanged() {
                                    console.log("hi");
                                    // for (var cal = 0; cal < client.getCalendars().length; cal++) {
                                    //     var events = client.getEvents(cal);

                                    //     for (var i = 0; i < events.length; i++) {
                                    //         if (events[i].dtstart.getDate() == dayDate.getDate() && events[i].dtstart.getYear() == dayDate.getYear() && events[i].dtstart.getMonth() == dayDate.getMonth()) {
                                    //             test = events[i].summary;
                                    //         }
                                    //     }
                                    // }
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