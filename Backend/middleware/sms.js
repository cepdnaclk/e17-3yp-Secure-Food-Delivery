require('dotenv').config();

const accountSid = process.env.TWILIO_ASID;
const autheToken = process.env.TWILIO_ATOK;

const client = require('twilio')(accountSid, autheToken);

function sendOTP(ctelno, otp) {
    var body = `Your OTP is ${otp.slice(0, 3)} ${otp.slice(3, 6)}.\nUnlock the carrier when delivery has arrived.\n\nSFD Team`;
    send(ctelno, body);
}

function sendMessage(ctelno, msg, orderid) {
    var body = `Your order (ID: ${orderid}) has ${msg}.\nPlease contact your restaurant for further information.\n\nSFD Team`;
    send(ctelno, body);
}

function send(ctelno, msg) {
    client.messages
        .create({
            body: msg,
            from: '+12186566813',
            to: '+94' + ctelno.slice(1, 10)
        })
        .then((message) => { return 1 })
        .catch((err) => { return 0 });
}

module.exports.sendOTP = sendOTP;
module.exports.sendMessage = sendMessage;
module.exports.send = send;