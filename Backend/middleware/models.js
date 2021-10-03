const ConnectDB = require('./database');
const otp = require('./sms');
const mapper = require('./ordersMap');

'use strict';

class Order {
    constructor(orderid, ctelno, deviceid) {
        this.id = orderid;
        this.telno = ctelno;
        this.deviceid = deviceid;
        this.state = 'on-going';
        this.unauthorizedAcc = false;
    }

    generateOTP() {
        var digits = '0123456789';
        var OTP = '';
        for (let i = 0; i < 6; i++) {
            OTP += digits[Math.floor(Math.random() * 10)];
        }
        this.otp = OTP;
        return OTP;
    }

    viewState() {
        return this.state;
    }

    done() {
        let sql = `CALL delivery_done("${this.id}")`;
        ConnectDB.query(sql, (err, result) => {
            if (err) return console.log(err.message);
            else {
                this.state = 'done';
                otp.sendMessage(this.telno, "done", this.id);
                return;
            }
        });
    }

    cancelled() {
        let sql = `CALL delivery_cancelled("${this.id}")`;
        ConnectDB.query(sql, (err, result) => {
            if (err) return console.log(err.message);
            else {
                this.state = 'cancelled';
                otp.sendMessage(this.telno, "cancelled", this.id);
                mapper.del(this.id);
                return;
            }
        });
    }

    confirm() {
        this.state = 'confirmed';
        let timer = setTimeout(function () { cancelled(); }, 900000);
        let check = setInterval(function () {
            if (this.state === 'done') {
                clearTimeout(timer);
                clearInterval(check);
            }
        }, 30000);
    }
}

module.exports = Order;