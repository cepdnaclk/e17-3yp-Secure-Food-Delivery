require('dotenv').config();

const accountSid = process.env.TWILIO_ASID;
const autheToken = process.env.TWILIO_ATOK;

const client = require('twilio')(accountSid, autheToken);

function sendOTP(ctelno, otp) {
    client.messages
        .create({
            body: `Your OTP is ${otp.slice(0, 3)} ${otp.slice(3, 6)}.\nUnlock the carrier when delivery has arrived.\n\nSFD Team`,
            from: '+12186566813',
            to: '+94' + ctelno.slice(1, 10)
        })
        .then((message) => { return 1 })
        .catch((err) => { return 0 });
}

function sendMessage(ctelno, msg, orderid) {
    client.messages
        .create({
            body: `Your order (ID: ${orderid}) has ${msg}.\nPlease contact your restaurant for further information.\n\nSFD Team`,
            from: '+12186566813',
            to: '+94' + ctelno.slice(1, 10)
        })
        .then((message) => { return 1 })
        .catch((err) => { return 0 });
}

module.exports.sendOTP = sendOTP;
module.exports.sendMessage = sendMessage;
