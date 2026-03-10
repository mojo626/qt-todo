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
        model: client.getTodos()

        delegate: CheckBox {
            checked: modelData.status
            text: modelData.summary
        }
    }
}