const authen = require('../middleware/authenticate');
const mapper = require('../middleware/ordersMap');
const ConnectDB = require('../middleware/database');
const mqtt = require('../middleware/mqttclient');
const Joi = require('joi');
const express = require('express');
const router = express.Router();

router.post('/unlock', authen, (req, res) => {
    let schema = Joi.string().min(6).max(6).required();

    let { error } = schema.validate(req.body.otp);
    if (error) return res.status(400).send(error);

    let order_obj = mapper.find(req.user.orderid);
    let otp = order_obj.otp;
    let state = order_obj.viewState();

    // OTP validation
    if (otp != req.body.otp) return res.status(400).send('access denied');
    // state validation
    if (state != 'confirmed') return res.status(401).send('error : rider on the way.. needs to confirm');
    else {
        let sql = `CALL device_mqtt("${order_obj.deviceid}")`;
        ConnectDB.query(sql, (err, result) => {
            if (err) return console.log(err.message);
            else {
                let mqttid = result[0].mqttID;
                mqtt.unLockingSignal(mqttid, true);  // send device to unlock signal
            }
        });
        order_obj.done();
        mapper.del(req.user.orderid);
        return res.send(`unlocked ${order_obj.deviceid}`);
    }
});

module.exports = router;