import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Color picker")
    color: "black"

    Item
    {
        width: 200; height: 200
        id: colorWheel
        Canvas
        {
            id: ring
            width: 200; height: 200
            property double wheelFullRadius: width / 2
            property double borderWidth: wheelFullRadius / 3
            property double wheelInnerRadius: wheelFullRadius - borderWidth

            function getColor() {
                return Qt.rgba(context.getImageData(area.mouseX, area.mouseY, 1, 1).data[0]/255,
                               context.getImageData(area.mouseX, area.mouseY, 1, 1).data[1]/255,
                               context.getImageData(area.mouseX, area.mouseY, 1, 1).data[2]/255,
                               context.getImageData(area.mouseX, area.mouseY, 1, 1).data[3]/255)
            }

            onPaint: {
                var context = getContext('2d')
                context.reset()
                context.arc(ring.wheelFullRadius, ring.wheelFullRadius, ring.wheelInnerRadius, 0, 2*Math.PI)
                var gradient = context.createConicalGradient( ring.wheelFullRadius, ring.wheelFullRadius, 0)
                gradient.addColorStop ( 0/6, "red" )
                gradient.addColorStop ( 1/6, "magenta" )
                gradient.addColorStop ( 2/6, "blue" )
                gradient.addColorStop ( 3/6, "cyan" )
                gradient.addColorStop ( 4/6, "lime" )
                gradient.addColorStop ( 5/6, "yellow" )
                gradient.addColorStop ( 6/6, "red" )
                context.strokeStyle = gradient
                context.lineWidth = ring.borderWidth
                context.stroke()
            }
            MouseArea {
                   id: area
                anchors.fill: parent
                onClicked: {colorShower.border.color = ring.getColor()}
            }
            Rectangle {
                id: colorShower
                width: parent.width / 2.1; height: parent.height / 2.1; radius: width / 2; color: "transparent"; border.width: 3
                anchors.centerIn: parent
            }
        }


    }
}



