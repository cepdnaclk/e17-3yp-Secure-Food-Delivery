const authen = require('../middleware/authenticate');
const ConnectDB = require('../middleware/database');
const mapper = require('../middleware/ordersMap');
const mqtt = require('../middleware/mqttclient');
const Joi = require('joi');
const express = require('express');
const router = express.Router();

// sends ongoing orders for perticular rider's carrier
router.get('/list', authen, async (req, res) => {
    let mobno = req.user.mobno;

    let sql = `SELECT deviceID FROM reg_rider WHERE reg_rider.mobNo = "${mobno}"`;
    ConnectDB.query(sql, (err, result) => {
        if (err) return res.status(404);
        else {
            let deviceid = result[0].deviceID;
            let sql = `CALL viewCurrentOrders("${deviceid}")`;
            ConnectDB.query(sql, (err, result) => {
                if (err) return res.status(400).send('db error');
                else {
                    return res.send(result[0]); // sends the ongoing orders details
                }
            });
        }
    });
});

router.get('/confirmed/:orderid', authen, (req, res) => {
    let schema = Joi.string().alphanum().min(4).max(10).required();

    let { error } = schema.validate(req.params.orderid);
    if (error) return res.status(400).send("incorrect orderid");

    try {
        let order_obj = mapper.find(req.params.orderid);
        order_obj.confirm();
    }
    catch (excepction) {
        return res.send(`not found ${req.params.orderid} ${excepction}`);
    }


    var data = { rfidUnlock: true };
    mqtt.send2device(req.user.deviceid, data);
    res.send(`confirmed delivery of ${req.params.orderid}`);
});

module.exports = router;