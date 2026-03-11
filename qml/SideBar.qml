import QtQuick
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient

Rectangle {
    anchors.fill: parent

    ListView {
        anchors.fill: parent
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
                    color: modelData.color
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