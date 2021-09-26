const ConnectDB = require('../middleware/database');
const Order = require('../middleware/models');
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
    ConnectDB.query(sql, (err, result) => {
        if (err) return res.status(406).send("duplicated entry");
        else {
            let order = new Order(req.body.orderid, req.body.ctelno, req.body.deviceid);
            let otp = order.generateOTP;

            
            res.status(201).send("order being delivering");
        }
    });

});

/*--------------Checking Order State--------------*/
router.get('/order-state/:orderid', async (req, res) => {
    //validate
    let schema = Joi.string().alphanum().min(4).max(10).required();

    let { error } = schema.validate(req.params.orderid);
    if (error) return res.status(400).send(error);

    //get the satus of the order from the database
    //send back the status of the order to client
    let sql = `SELECT state FROM order_handle WHERE orderID = "${req.params.orderid}"`;
    ConnectDB.query(sql, (err, result) => {
        if (err) res.status(404).send(err);
        else {
            res.status(200).send(result);
        }
    });

});

module.exports = router;