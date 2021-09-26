const mysql = require('mysql');

const ConnectDB = mysql.createConnection({
    host: "localhost", //corresponding host address
    user: "root", //user name
    password: "nadiw9811", //password
    port: 3307 //port number
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