import QtQuick
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient
import CalendarUtil
import QtQuick.Controls.FluentWinUI3


ApplicationWindow {
    id: window
    width: 800
    height: 600
    visible: true

    

    function changeCalendar(newCal) {
        mainView.calendar = newCal
    }


    CaldavClient {
        id: client
    }

    CalendarUtil {
        id: calendarUtil
    }


    FontLoader {
        id: materialIcons
        source: "./fonts/MaterialDesignIconsDesktop.ttf"
    }

    RowLayout {
        anchors.fill: parent

        Rectangle {
            id: sidePanelDrawer

            property bool isVisible: true
            
            Layout.preferredWidth: isVisible ? 200 : 0
            Layout.fillHeight: true

            Behavior on Layout.preferredWidth {
                NumberAnimation { duration: 100 }
            }
            

            SideBar {
                anchors.fill: parent
            }
        }


        MainView {
            id: mainView

            property alias drawerVisible: sidePanelDrawer.isVisible

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    

    
}
