const mysql = require('mysql');

const ConnectDB = mysql.createConnection({
    host: "", //corresponding host address
    user: "", //user name
    password: "", //password
    port: 3306 //port number
});

ConnectDB.connect(function (err) {
    if (err) console.log(err.message);
    else {
        ConnectDB.query("USE sfd_db", (err, result) => {
            if (!err) console.log("db connected");
            else console.log("db not connected");
        });
    }
});

module.exports = ConnectDB;