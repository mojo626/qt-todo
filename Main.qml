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

    Drawer {
        id: drawer
        width: 200
        height: window.height

        modal: false
        interactive: true

        visible: true

        SideBar {}
    }

	TodoList {


		transform: Translate {
            x: drawer.position * 200
        }
	}
    
}
