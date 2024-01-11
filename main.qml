import QtQuick
import QtQuick.Window
import QtQuick.LocalStorage
import QtQuick.Controls
import "Database.js" as JS

Window {
    id: window
    visible: true
    width: Screen.width / 2
    height: Screen.height / 1.8
    title: qsTr("Trains")

    ListView {
    id: listView
    width: 500
    height: 500
    anchors.top: parent.top
    anchors.left: parent.left
    spacing: 10

    model: ListModel { id: trainModel }

    delegate: Rectangle {
        width: listView.width
        height: 120
        color: "lightblue"
        border.color: "black" 
        border.width: 1

        Column {
            anchors.leftMargin: 3
            anchors.fill: parent
            spacing: 3

            Text {
                text: "Номер поезда: " + model.trainNum
                font.bold: true
                wrapMode: Text.WordWrap
            }

            Text {
                text: "Пункт отправления: " + model.departure
                wrapMode: Text.WordWrap
            }

            Text {
                text: "Пункт назначения: " + model.destination
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Время отправления: " + model.departureTime
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Время прибытия: " + model.arrivalTime
                wrapMode: Text.WordWrap
            }

            Row {
                spacing: 10
                Text {
                    text: "Стоимость билета: " + model.ticketPrice
                    wrapMode: Text.WordWrap
                }

                Button {
                    anchors.bottomMargin: 15
                    anchors.rightMargin: 15
                    text: "Удалить"
                    onClicked: {
                        JS.dbDelete(model.trainNum)
                        trainModel.clear()
                        JS.dbReadAll()
                    }
                }
            }
        }
    }
}

Button {
    id: buttonAdd
    width: 150
    height:50
    text: qsTr("Добавить поезд")
    anchors.bottom: parent.bottom
    anchors.right: parent.right

    Rectangle {
        width: buttonAdd.width
        height: buttonAdd.height
        color: "lightblue"
        border.color: "black"
        border.width: 1

        Text {
            anchors.centerIn: parent
            text: buttonAdd.text
        }
    }

    onClicked: {
        var component = Qt.createComponent("TrainDialog.qml");
        var TrainDialog = component.createObject(window, {x:400, y: 400});
        TrainDialog.open()
        TrainDialog.accepted.connect(function() {
            JS.dbInsert(TrainDialog.trainNum, TrainDialog.departure, TrainDialog.destination,TrainDialog.departureTime, TrainDialog.arrivalTime,TrainDialog.ticketPrice)                    
            trainModel.clear()
            JS.dbReadAll()
            TrainDialog.destroy()
        });
    }
}

    Column {
        id: column1
        anchors.top: parent.top
        anchors.right: parent.right
        spacing: 10
        padding: 10

    Label {
        text: "Вывод поездов по заданному пункту отправления и времени прибытия"
        width: 200
    }

    Row {
        spacing: 10

        TextField {
            width: 100
            id: departureTextField
            placeholderText: "Введите пункт отправления"
        }

        TextField {
            width: 100
            id: arrivalTimeTextField
            placeholderText: "Введите время прибытия"
        }

        Button {
            width: 100
            id: buttonSearch
            text: "Найти поезда"
            onClicked: {
                var departure = departureTextField.text
                var arrivalTime = arrivalTimeTextField.text

                trainModel.clear()
                JS.dbReadAllByDepartureAndArrival(departure, arrivalTime)
            }
        }
        Button {
        id: buttonShow
        text: "Показать все поезда"
        onClicked: {
            trainModel.clear()
            JS.dbReadAll()
        }
    }
    }
}

    Column {
    anchors.top: column1.bottom 
    anchors.right: parent.right
    spacing: 10
    padding: 10

    Label {
        text: "Вывод поездов по заданному пункту отправления и назначения"
        width: 200
    }

    Row {
        spacing: 10

        TextField {
            width: 100
            id: departureTextField2
            placeholderText: "Введите пункт отправления"
        }

        TextField {
            width: 100
            id: destinationTextField
            placeholderText: "Введите пункт прибытия"
        }

        Button {
            width: 100
            id: buttonSearch2
            text: "Найти поезда"
            onClicked: {
                var departure = departureTextField2.text
                var destination = destinationTextField.text

                trainModel.clear()
                JS.dbReadAllByDepartureAndDestination(departure, destination)
            }
        }
        Button {
        id: buttonShow2
        text: "Показать все поезда"
        onClicked: {
            trainModel.clear()
            JS.dbReadAll()
        }
    }
    }
    
}

    
    Component.onCompleted: {
        JS.dbInit()
        JS.dbReadAll() 
    }
}
