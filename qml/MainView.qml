import QtQuick
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient
import QtQuick.Controls.FluentWinUI3

Rectangle {
    id: mainView

    color: palette.base

    anchors.fill: parent

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
                    iconCode: "F10AA"
                    onClicked: () => drawerVisible = !drawerVisible
                }
            }
        }

        
        
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: palette.base

            ListView {
                anchors.fill: parent
                anchors.margins: 10
                
                spacing: 20
                model: client.getTodos(mainView.calendar)

                delegate: CheckBox {
                    checked: modelData.status
                    text: modelData.summary
                }
            }
        }
        
    }

    
}