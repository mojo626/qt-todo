import QtQuick
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient
import QtQuick.Controls.FluentWinUI3


Rectangle {
    color: palette.base

    ListView {
        anchors.fill: parent
        anchors.margins: 10
        
        spacing: 20
        model: client.getTodos(mainView.calendar)

        delegate: CheckBox {
            checked: modelData.status
            text: modelData.summary
            visible: !modelData.status
        }
    }
}