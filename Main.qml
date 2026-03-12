import QtQuick
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient
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


    FontLoader {
        id: materialIcons
        source: "./fonts/MaterialDesignIconsDesktop.ttf"
    }

    Drawer {
        id: sidePanelDrawer
        width: 200
        height: window.height

        modal: false
        interactive: false

        visible: true

        SideBar {}
    }

	MainView {
        id: mainView

        property alias drawerVisible: sidePanelDrawer.visible

		transform: Translate {
            x: sidePanelDrawer.position * 200
        }
	}

    
}
