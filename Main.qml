import QtQuick
import frontend
import QtQuick.Controls 2.1
import QtQuick.Layouts
import CaldavClient



ApplicationWindow {
    id: window
    width: 800
    height: 600
    visible: true

    // Variable counter
    property var counter: 0


    CaldavClient {
        id: client
    }

    FontLoader {
        id: iconFont
        source: "./fonts/MaterialIcons-Regular.ttf"
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

	TodoList {
        property alias drawerVisible: sidePanelDrawer.visible

		transform: Translate {
            x: sidePanelDrawer.position * 200
        }
	}
    
}
