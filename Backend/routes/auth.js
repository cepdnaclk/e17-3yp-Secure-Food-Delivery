const ConnectDB = require('../middleware/database');
const config = require('config');
const jwt = require('jsonwebtoken');
const Joi = require('joi');
const bcrypt = require('bcrypt');
const express = require('express');
const router = express.Router();

/*--------------Loging Rider--------------*/
router.post('/rider', async (req, res) => {
    let schema = Joi.object({
        mobno: Joi.string().pattern(/^[0-9]+$/).min(10).max(10).required(),
        password: Joi.string().min(5).max(10).required()
    });

    let { error } = schema.validate(req.body);
    if (error) return res.status(400).send("incorrect credentials");

    //verify whether rider has registered - send back jwt token
    let sql = `SELECT * FROM reg_rider WHERE reg_rider.mobNo = "${req.body.mobno}"`;
    ConnectDB.query(sql, async (err, result) => {
        if (!result.length | err) return res.status(400).send("not registered");
        else {
            bcrypt.compare(req.body.password, result[0].rpassword).then((result) => {
                if (!result) return res.status(400).send("invalid mobile number or password");
                else {
                    const rtoken = jwt.sign({ mobno: req.body.mobno, role: "rider" }, config.get('jwtPrivateKey'));
                    return res.send(rtoken);
                }
            });
        }
    });
});

router.post('/customer', async (req, res) => {
    let schema = Joi.object({
        mobno: Joi.string().pattern(/^[0-9]+$/).min(10).max(10).required(),
        orderid: Joi.string().alphanum().min(4).max(10).required(),
    });

    let { error } = schema.validate(req.body);
    if (error) return res.status(400).send("incorrect credentials");

    let sql = `SELECT mobNo, state, deviceID FROM order_handle WHERE order_handle.orderID = "${req.body.orderid}"`;
    ConnectDB.query(sql, (err, result) => {
        if (err) return res.status(401).send('error occured');
        else {
            if (result[0].state != 'cancelled' & result[0].state != 'done') {
                const ctoken = jwt.sign({ mobno: req.body.mobno, deviceid: result[0].deviceID, orderid: req.body.orderid, role: "customer" }, config.get('jwtPrivateKey'));
                return res.send(ctoken);
            }
            else {
                return res.status(404).send('processed already');
            }
        }
    });
});

module.exports = router;