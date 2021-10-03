const ConnectDB = require('../middleware/database');
const Order = require('../middleware/models');
const mapper = require('../middleware/ordersMap');
const sms = require('../middleware/sms');
const Joi = require('joi');
const express = require('express');
const router = express.Router();

router.use(express.json());

/* --------------Route Handellers--------------*/
/* new order from respective restaurant */
router.post('/new-order', async (req, res) => {
    //inputs validatation
    let schema = Joi.object({
        orderid: Joi.string().alphanum().min(4).max(10).required(),
        ctelno: Joi.string().pattern(/^[0-9]+$/).min(10).max(10).required(),
        deviceid: Joi.string().alphanum().min(4).max(10).required()
    });

    let { error } = schema.validate(req.body);
    if (error) return res.status(400).send("incorrect inputs");

    //put the data into database
    //send processing message
    let sql = `INSERT INTO orders VALUES("${req.body.orderid}", "${req.body.ctelno}", "${req.body.deviceid}")`;
    ConnectDB.query(sql, async (err, result) => {
        if (err) return res.status(406).send("duplicated entry");
        else {
            let order = new Order(req.body.orderid, req.body.ctelno, req.body.deviceid);
            let otp_num = order.generateOTP();

            sms.sendOTP(req.body.ctelno, otp_num); // send OTP through sms

            let sql = `CALL device_mqtt("${req.body.deviceid}")`;
            ConnectDB.query(sql, async (err, result) => {
                if (err) return console.log(err.message);
                else {
                    let mqttid = result[0].mqttID;
                    mqtt.orders(mqttid, req.body.orderid, '');  //sends rfid tag code along with the device id and order id to device
                }
            });

            mapper.add(req.body.orderid, order); // add new order obj into server's ds

            let state = order.viewState();
            res.status(200).send(`order state ${state}`);
        }
    });

});

/*--------------Checking Order State--------------*/
router.get('/order-state/:orderid', async (req, res) => {
    //validate
    let schema = Joi.string().alphanum().min(4).max(10).required();

    let { error } = schema.validate(req.params.orderid);
    if (error) return res.status(400).send(error);

    let state = mapper.find(req.params.orderid).viewState();
    res.status(200).send(state);

});

module.exports = router;