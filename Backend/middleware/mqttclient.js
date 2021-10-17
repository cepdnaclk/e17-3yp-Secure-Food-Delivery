const mqtt = require('mqtt');
const fs = require('fs');
const ConnectDB = require('./database');
const sms = require('./sms');

var caFile = fs.readFileSync("../certs/mqtt/AmazonRootCA1.pem");
var certFile = fs.readFileSync("../certs/mqtt/server_certificate.pem.crt");
var keyFile = fs.readFileSync("../certs/mqtt/server_private.pem.key");

var opts = {
    connectTimeout: 5000,
    ca: [caFile],
    cert: certFile,
    key: keyFile,
    qos: 1,
    port: 8883,
    clientId: 'api',
    clean: false
}

const client = mqtt.connect('mqtts://a32npcehyv5ifz-ats.iot.us-east-1.amazonaws.com:8883', opts);

var topics = ['sfd0001'];

client.on('connect', () => {
    for (var count = 0; count < topics.length; count++) {
        client.subscribe(topics[count], { qos: 1 });
        console.log(`Subscribed ${topics[count]}`);
    }
});

function send2device(topic, data) {
    client.publish(topic, JSON.stringify(data), { qos: 1 });
}

client.on("message", (topic, message) => {
    message = JSON.parse(message);

    if (message.unAuth) {
        // do the thing what has to be done when an unauthorized access has detetcted
        var sql = `SELECT mobNo FROM order_handle WHERE order_handle.deviceID = "${topic}" and order_handle.state = 'on-going'`;
        ConnectDB.query(sql, (err, result) => {
            if (err) console.log(`failed to send current orders to ${topic}`);
            else {
                var msg = `Un-Athorized access has detected on your food carrier - ${topic}.\nIf your food not received, please contact restaurant immediately.\n\nSFD Team`;
                for (var i = 0; i < result[0]; i++) {
                    sms.send(result[0][i], msg);
                }
            }
        });
    }

    if (message.reqOrder) {
        // do the thing when requesting orders at initial state
        // deviceID should be the topic
        var sql = `SELECT orderID, rfidCode, state FROM order_handle WHERE order_handle.deviceID = "${topic}" and order_handle.state = 'on-going'`;
        ConnectDB.query(sql, (err, result) => {
            if (err) console.log(`failed to send current orders to ${topic}`);
            else {
                var array = [];
                for (var i = 0; i < result[0].length; i++) {
                    array[i] = [result[0][i].orderID, result[0][i].rfidCode, result[0][i].state];
                }
                var data = {
                    recvOrder: true,
                    body: array
                };
                send2device(topic, data);
            }
        });
    }
});


module.exports.send2device = send2device;