import QtQuick
import QtQml
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient
import QtQuick.Controls.FluentWinUI3

Rectangle {
    id: monthView

    color: palette.base

    

    ListView {
        id: weekList

        anchors.fill: parent

        model: weekModel

        orientation: ListView.Vertical

        //interactive: false

        snapMode: ListView.SnapOneItem
        //highlightRangeMode: ListView.StrictlyEnforceRange

        onCountChanged: {
            if (count > 0) {
                positionViewAtIndex(Math.floor(count / 2), ListView.Center);
                weekList.currentIndex = Math.floor(count / 2);
            }
        }

        // MouseArea {
        //     acceptedButtons: Qt.NoButton // we handle manually

        //     anchors.fill: parent

        //     onWheel: (event) => {
        //         if (event.angleDelta.y > 0) {
        //             weekList.currentIndex = Math.max(0, weekList.currentIndex - 1)
        //         } else if (event.angleDelta.y < 0) {
        //             weekList.currentIndex = Math.min(weekList.count - 1, weekList.currentIndex + 1)
        //         }

        //         weekList.positionViewAtIndex(
        //             weekList.currentIndex,
        //             ListView.Contain
        //         )
        //         console.log(event.angleDelta.y);

        //         event.accepted = true
        //     }
        // }

        delegate: MonthViewWeekRow {
            height: stackLayout.height / 6
            width: ListView.view.width
        }
        
    }

    
}