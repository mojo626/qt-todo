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

        month: Calendar.March
        year: 2026
        locale: Qt.locale("en_US")

        spacing: 0
        
        delegate: Rectangle {
            border.width: 0.5
            border.color: palette.button

            color: palette.base

            ColumnLayout {
                anchors.fill: parent

                Text {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 10

                    Layout.margins: 5

                    horizontalAlignment: Text.AlignRight
                    
                    opacity: model.month === control.month ? 1 : 0.5
                    text: model.day
                    color: palette.text


                }

                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

            }

            
        }
        
    }

    
}