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

    ListView {
        anchors.fill: parent

        Rectangle {
            color: palette.window

            Layout.fillWidth: true
            Layout.preferredHeight: 50

            z: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                
                
            }
        }
        
    }

    
}