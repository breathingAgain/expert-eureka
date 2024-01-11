import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Dialog {
    property int trainNum
    property string departure
    property string destination
    property string departureTime
    property string arrivalTime
    property int ticketPrice
    standardButtons: Dialog.Cancel | Dialog.Ok
    modal: true
    Column {
        id: layout
        objectName: "layout"
        anchors.fill: parent
        TextField {
            id: trainNumField
            width: parent.width
            placeholderText: qsTr("Номер поезда")
        }
        TextField {
            id: departureField
            width: parent.width
            placeholderText: qsTr("Пункт отправления")
        }
        TextField {
            id: destinationField
            width: parent.width
            placeholderText: qsTr("Пункт Назначения")
        }
        TextField {
            id: departureTimeField
            width: parent.width
            placeholderText: qsTr("Время отправления")
        }
        TextField {
            id: arrivalTimeField
            width: parent.width
            placeholderText: qsTr("Время прибытия")
        }
        TextField {
            id: ticketPriceField
            width: parent.width
            placeholderText: qsTr("Стоимость билета")
        }
    }
    onAccepted: {
             trainNum = trainNumField.text
             departure = departureField.text
             destination = destinationField.text
             departureTime = departureTimeField.text
             arrivalTime = arrivalTimeField.text
             ticketPrice = ticketPriceField.text
        }
 
}
