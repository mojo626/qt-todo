pragma Singleton
import QtQuick
import frontend

QtObject {
    function mdi(code) {
        return String.fromCodePoint(parseInt(code, 16))
    }
}