const mqtt = require('mqtt');
const fs = require('fs');
const ConnectDB = require('./database');
const sms = require('./sms');

var options = {
    host: 'f8b365f4facf4c80bafb40a579725058.s2.eu.hivemq.cloud',
    port: 8883,
    protocol: 'mqtts',
    username: 'teamsfd',
    password: 'sfd@3yp22'
}

var client = mqtt.connect("mqtt://broker.hivemq.com");

var topics = ['sfd0001', 'sfd0002', 'sfd0003'];

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
            if (err) console.log(`No ongoing-orders`);
            else {
                var msg = `Un-Athorized access has detected on your food carrier - ${topic}.\nIf your food not received, please contact restaurant immediately.\n\nSFD Team`;
                for (var i = 0; i < result[0]; i++) {
                    sms.send(result[0][i], msg);
                }
            }
        });
    }

    if (message.reqOrder) {
        console.log("req order");
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
                send2device(topic, JSON.stringify(data));
            }
        });
    }

    if (message.service_open) {
        var sql = `SELECT mobNo FROM order_handle WHERE order_handle.deviceID = "${topic}" and order_handle.state = 'on-going'`;
        ConnectDB.query(sql, (err, result) => {
            if (err) console.log(`Error with database`);
            else {
                if (result.length == 0) {
                    send2device(`${topic}/unlock/service_open`, { "service_open": "true" });
                }
            }
        });
    }
    
});

send2device("sfd")


module.exports.send2device = send2device;