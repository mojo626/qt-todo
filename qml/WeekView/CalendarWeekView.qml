import QtQuick
import QtQml
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient
import QtQuick.Controls.FluentWinUI3

Rectangle {
    id: weekView

    color: palette.base

    property var hourHeight: 50

    

    Flickable {

        Canvas {
            anchors.fill: parent


            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)

                ctx.strokeStyle = palette.button
                ctx.lineWidth = 1

                for (var i = 0; i < 24; i++) {
                    var y = i * weekView.hourHeight

                    ctx.beginPath()
                    ctx.moveTo(0, y)
                    ctx.lineTo(width, y)
                    ctx.stroke()
                }
            }
        }
        

        id: verticalFlick

        anchors.fill: parent
        contentHeight: 24 * weekView.hourHeight   // total day height
        clip: true
        

        ListView {
            id: dayList

            anchors.left: parent.left
            anchors.right: parent.right
            height: verticalFlick.contentHeight

            model: dayModel

            orientation: ListView.Horizontal

            snapMode: ListView.SnapOneItem

            clip: true

            onCountChanged: {
                console.log(count);
                if (count > 0) {
                    positionViewAtIndex(Math.floor(count / 2), ListView.Contain);
                    dayList.currentIndex = Math.floor(count / 2);
                }
            }

            delegate: WeekViewDay {
                width: dayList.width / 7
                height: dayList.height

                date: model.startDate
            }
        }
    }

    

    
}