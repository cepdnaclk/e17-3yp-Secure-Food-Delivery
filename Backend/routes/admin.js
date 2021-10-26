const authen = require('../middleware/authenticate');
const ConnectDB = require('../middleware/database');
const jwt = require('jsonwebtoken');
const config = require('config');
const Joi = require('joi');
const express = require('express');
const { json } = require('express');
const router = express.Router();

router.use(express.json());

router.post('/login', async (req, res) => {
    let schema = Joi.object({
        username: Joi.string().min(5).max(10).required(),
        password: Joi.string().min(5).max(10).required()
    });

    let { error } = schema.validate(req.body);
    if (error) return res.status(400).json({ message: 'Incorrect Credentials' });
    
    let sql = `SELECT * FROM admins WHERE admins.userName = "${req.body.username}"`;
    ConnectDB.query(sql, async (err, result) => {
        if (!result.length | err) return res.status(400).json({ message: "Not Registered" });
        else {
            var queryResult = result[0];
            if (req.body.password == queryResult.aPassword) {
                const atoken = jwt.sign({ role: "admin" }, config.get('jwtPrivateKey'));
                return res.send(atoken);
            } else {
                return res.status(400).json({ message: "Incorrect Credentials" });
            }
        }
    });

});

router.get('/list/customers', authen, async (req, res) => {

    var sql = `SELECT cName, mobNo, cAddress FROM reg_customer WHERE reg_customer.rfid = 'null'`;
    ConnectDB.query(sql, async (err, result) => {
        if (err | !result.length) return res.status(404);
        else {
            return res.send(result[0]);
        }
    });

});

router.get('/list/riders', authen, async (req, res) => {

    var sql = `SELECT rName, mobNo, deviceID FROM reg_rider`;
    ConnectDB.query(sql, async (err, result) => {
        if (err | !result.length) return res.status(404);
        else {
            return res.send(result[0]);
        }
    });

});

router.post('/rfid', authen, async (req, res) => {
    let schema = Joi.object({
        rfid: Joi.string().alphanum().min(4).max(10).required(),
        mobno: Joi.string().pattern(/^[0-9]+$/).min(10).max(10).required()
    });

    let { error } = schema.validate(req.body);
    if (error) return res.status(400).send(error);

    var sql = `UPDATE reg_customer SET reg_customer.rfid = "${req.body.rfid}" WHERE reg_customer.mobNo = "${req.body.mobno}"`;
    ConnectDB.query(sql, async (err, result) => {
        if (err) return res.status(400).json({ message: "User not found" });
        else {
            return res.json({ message: "Successfully Updated" });
        }
    });

});

router.post('/add', authen, async (req, res) => {
    let schema = Joi.object({
        deviceid: Joi.string().alphanum().min(4).max(10).required(),
        mqttid: Joi.string().pattern(/^[0-9]+$/).max(10).required()
    });

    let { error } = schema.validate(req.body);
    if (error) return res.status(400).send(error);

    var sql = `INSERT INTO reg_device(deviceID, mqttID) VALUES ("${req.body.deviceid}","${req.body.mqttid}")`;
    ConnectDB.query(sql, async (err, result) => {
        if (err) return res.status(400).json({ message: "Error occured" });
        else {
            return res.json({ message: `Successfully added - ${req.body.deviceid}` });
        }
    });

});

router.post('/remove/device', authen, async (req, res) => {
    let schema = Joi.string().alphanum().min(4).max(10).required();

    let { error } = schema.validate(req.body.deviceid);
    if (error) return res.status(400).send(error);

    var sql = `DELETE FROM reg_device WHERE reg_device.deviceID = "${req.body.deviceid}"`;
    ConnectDB.query(sql, async (err, result) => {
        if (err | !result.affectedRows) return res.status(400).json({ message: "Error occured" });
        else {
            return res.json({ message: `Successfully deleted - ${req.body.deviceid}` });
        }
    });

});

router.post('/remove/rider', authen, async (req, res) => {
    let schema = Joi.string().alphanum().min(4).max(10).required();

    let { error } = schema.validate(req.body.mobno);
    if (error) return res.status(400).send(error);

    var sql = `DELETE FROM reg_rider WHERE reg_rider.mobNo = "${req.body.mobno}"`;
    ConnectDB.query(sql, async (err, result) => {
        if (err | !result.affectedRows) return res.status(400).json({ message: "Error occured" });
        else {
            return res.json({ message: `Successfully deleted - ${req.body.mobno}` });
        }
    });

});

module.exports = router;