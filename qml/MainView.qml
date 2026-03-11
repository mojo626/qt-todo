import QtQuick
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient

Rectangle {
    id: mainView

    anchors.fill: parent

    property int calendar: 0

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            
            IconButton {
                iconCode: "F10AA"
                onClicked: () => drawerVisible = !drawerVisible
            }
        }
        

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 20
            model: client.getTodos(mainView.calendar)

            delegate: CheckBox {
                checked: modelData.status
                text: modelData.summary
            }
        }
    }

    
}