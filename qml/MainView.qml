import QtQuick
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient
import QtQuick.Controls.FluentWinUI3

Rectangle {
    id: mainView

    color: palette.base


    property int calendar: 0

    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            color: palette.window

            Layout.fillWidth: true
            Layout.preferredHeight: 50

            z: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                
                IconButton {
                    Layout.preferredWidth: 30
                    Layout.preferredHeight: 30

                    Layout.alignment: Qt.AlignVCenter

                    iconCode: "F10AA"
                    onClicked: () => drawerVisible = !drawerVisible
                }

                TabBar {
                    id: bar
                    

                    Layout.alignment: Qt.AlignVCenter

                    TabButton {
                        text: qsTr("Month")
                        width: 100
                    }
                    TabButton {
                        text: qsTr("Todos")
                        width: 100
                    }
                }
                
            }
        }

        StackLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            currentIndex: bar.currentIndex

            CalendarMonthView {
            
            }

            TodoView {

            }
        }
        
        
        
    }

    
}