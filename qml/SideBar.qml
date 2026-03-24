import QtQuick
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient
import CalendarUtil
import QtQuick.Controls.FluentWinUI3

Rectangle {
    color: palette.window

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 50

            IconButton {
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30

                iconCode: "F0349"
                onClicked: calendarUtil.getListOfWeeks()
            }

            Item {
                Layout.fillWidth: true
            }

            IconButton {
                Layout.preferredWidth: 30
                Layout.preferredHeight: 30

                iconCode: "F0493"
            }
        }

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 20
            model: client.getCalendars()

            delegate: Button {

                anchors.left: parent.left
                anchors.right: parent.right

                flat: true

                onClicked: window.changeCalendar(modelData.id)

                contentItem: RowLayout {

                    Text {  
                        font.family: materialIcons.name
                        font.pixelSize: 20
                        text: Icons.mdi("F0765")
                        color: modelData.color.substring(0, 7)
                    }

                    Label {
                        id: content

                        text: modelData.display_name
                        font.pixelSize: 15
                        horizontalAlignment: Label.AlignLeft

                    }
                }
            } 
            
            
        }
 
    }

      
    
}