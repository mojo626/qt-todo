import QtQuick
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts

Button {
    id: root

    property string iconCode

    Layout.preferredWidth: 30
    Layout.preferredHeight: 30

    flat: true

    contentItem: Label {
        text: Icons.mdi(root.iconCode)
        font.family: materialIcons.name
        font.pixelSize: 20
        horizontalAlignment: Label.AlignHCenter
        verticalAlignment: Label.AlignVCenter
    }
}