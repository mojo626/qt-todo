import QtQuick
import frontend
import QtQuick.Controls 2.1
import CaldavClient

ApplicationWindow {
    id:rectangle
    width:  425
    height: 500
    visible: true
	

    // Variable counter
    property var counter: 0

	CaldavClient {
		id: client
	}
	
	

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
