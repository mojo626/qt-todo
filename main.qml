import QtQuick
import frontend
import QtQuick.Controls 2.1
import QtQuick.Window 2.0
import CaldavClient

Window {
    id:     rectangle
    x: 0
    y: 0

    width:  425
    height: 500
    color: "#5bedbc"
    visible: true

    // Variable counter
    property var counter: 0

	CaldavClient {
		id: client
	}

    Label{
        id: label
        text: "A Label text"
        y:  200
		anchors.horizontalCenter: parent.horizontalCenter
	}

	Button{
		id:   button1      // Unique identifier in QT
		text: "Click me"
		anchors.verticalCenterOffset: 29
		anchors.horizontalCenterOffset: 0 // Button
		//y:    400
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter:   parent.verticalCenter

		onClicked: {
			console.log(client.getTodos());
		}
	}

}
