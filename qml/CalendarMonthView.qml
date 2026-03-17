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

    MonthGrid {
        id: control

        anchors.fill: parent

        month: Calendar.December
        year: 2015
        locale: Qt.locale("en_US")
        
        delegate: Text {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            opacity: model.month === control.month ? 1 : 0
            text: model.day
            color: palette.text
        }
    }

    
}