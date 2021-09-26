const ConnectDB = require('../middleware/database');

class Order {
    constructor(orderid, ctelno, deviceid) {
        this.id = orderid;
        this.telno = ctelno;
        this.deviceid = deviceid;
    }

    generateOTP() {
        var digits = '0123456789';
        let OTP = '';
        for (let i = 0; i < 6; i++) {
            OTP += digits[Math.floor(Math.random() * 10)];
        }
        this.otp = OTP;
        return OTP;
    }

    viewState() {
        let sql = `SELECT state FROM order_handle WHERE order_handle.orderID = "${this.id}"`;
        ConnectDB.query(sql, (err, result) => {
            if (err) return console.log(err.message);
            else {
                this.state = result[0];
                return result[0];
            }
        });
    }

    done() {
        let sql = `CALL delivery_done("${this.id}")`;
        ConnectDB.query(sql, (err, result) => {
            if (err) return console.log(err.message);
            else {
                this.state = 'done';
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
                return;
            }
        });
    }
}

module.exports = Order;