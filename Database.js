function dbInit() {
    var db = LocalStorage.openDatabaseSync("Train_DB", "", "Trains", 1000000)
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS train_table (trainNum int, departure text, destination text, departureTime text, arrivalTime text, ticketPrice int)')
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    }
}

function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("Train_DB", "",
                                               "Trains", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbInsert(trainNum, departure, destination, departureTime, arrivalTime, ticketPrice)
{
    var db = dbGetHandle()
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO train_table VALUES(?, ?, ?, ?, ?, ?)',
                      [trainNum, departure, destination, departureTime, arrivalTime, ticketPrice])
        var result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId
    })
    return rowid;
}

function dbDelete(trainNum) {
    var db = dbGetHandle();
    var rowid = 0;
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM train_table WHERE trainNum = ?', [trainNum]);
        rowid = tx.rowsAffected;
    });
    return rowid;
}
    

function dbReadAll()
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT * FROM train_table order by rowid desc')
        for (var i = 0; i < results.rows.length; i++) {
            trainModel.append({
                                 trainNum: results.rows.item(i).trainNum,
                                 departure: results.rows.item(i).departure,
                                 destination: results.rows.item(i).destination,
                                 departureTime: results.rows.item(i).departureTime,
                                 arrivalTime: results.rows.item(i).arrivalTime,
                                 ticketPrice: results.rows.item(i).ticketPrice
                             })
             console.log(trainModel.count)
        }
    })
}


function dbReadAllByDepartureAndArrival(departure, arrivalTime) {
    var db = dbGetHandle();
    db.transaction(function (tx) {
        try {
            var results = tx.executeSql(
                'SELECT * FROM train_table WHERE departure=? AND arrivalTime=? ORDER BY rowid DESC',
                [departure, arrivalTime]
            );
            for (var i = 0; i < results.rows.length; i++) {
                trainModel.append({
                    trainNum: results.rows.item(i).trainNum,
                    departure: results.rows.item(i).departure,
                    destination: results.rows.item(i).destination,
                    departureTime: results.rows.item(i).departureTime,
                    arrivalTime: results.rows.item(i).arrivalTime,
                    ticketPrice: results.rows.item(i).ticketPrice
                });
            }
        } catch (err) {
            console.error("Error reading from the database: " + err);
        }
    });
}

function dbReadAllByDepartureAndDestination(departure, destination) {
    var db = dbGetHandle();
    db.transaction(function (tx) {
        try {
            var results = tx.executeSql(
                'SELECT * FROM train_table WHERE departure=? AND destination=? ORDER BY rowid DESC',
                [departure, destination]
            );
            for (var i = 0; i < results.rows.length; i++) {
                trainModel.append({
                    trainNum: results.rows.item(i).trainNum,
                    departure: results.rows.item(i).departure,
                    destination: results.rows.item(i).destination,
                    departureTime: results.rows.item(i).departureTime,
                    arrivalTime: results.rows.item(i).arrivalTime,
                    ticketPrice: results.rows.item(i).ticketPrice
                });
            }
        } catch (err) {
            console.error("Error reading from the database: " + err);
        }
    });
}






    
    