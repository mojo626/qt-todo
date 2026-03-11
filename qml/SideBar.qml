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

        delegate: RowLayout {
            Label {
                id: content

                text: modelData.display_name
                font.pixelSize: 30
                horizontalAlignment: Label.AlignHCenter

            }
        }
        
    }
   
    
}