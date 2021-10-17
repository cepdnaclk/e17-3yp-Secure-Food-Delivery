const ConnectDB = require('../middleware/database');
const Joi = require('joi');
const bcrypt = require('bcrypt');
const express = require('express');
const router = express.Router();

router.post('/customer', async (req, res) => {
    let schema = Joi.object({
        mobno: Joi.string().pattern(/^[0-9]+$/).min(10).max(10).required(),
        cname: Joi.string().min(4).max(20).required(),
        caddress: Joi.string().min(4).max(50).required(),
        email: Joi.string().email().max(50).required(),
    });

    let { error } = schema.validate(req.body);
    if (error) return res.status(400).send("incorrect inputs");

    //verify whether user has registered so far and
    //insert new record to database
    let sql = `INSERT INTO reg_customer(mobNo, cName, cAddress, email) VALUES ("${req.body.mobno}", "${req.body.cname}", "${req.body.caddress}", "${req.body.email}")`;
    ConnectDB.query(sql, (err, result) => {
        if (!err) return res.send(`registered ${req.body.mobno}`);
        return res.status(406).send(`faild to register ${req.body.mobno}`);
    });
});

router.post('/rider', async (req, res) => {
    let schema = Joi.object({
        password: Joi.string().min(5).max(10).required(),
        rname: Joi.string().min(4).max(20).required(),
        mobno: Joi.string().pattern(/^[0-9]+$/).min(10).max(10).required(),
        deviceid: Joi.string().alphanum().min(4).max(10).required()
    });

    let { error } = schema.validate(req.body);
    if (error) return res.status(400).send("incorrect inputs");

    //verify whether rider hase registered so far and
    //insert new record to database

    const salt = await bcrypt.genSalt(5);
    let password = req.body.password;
    password = await bcrypt.hash(password, salt);

    let sql = `SELECT mobNo FROM reg_rider WHERE reg_rider.deviceID = "${req.body.deviceid}"`;
    ConnectDB.query(sql, (err, result) => {
        if (err | result.length) return res.status(400).send(`cannot register for ${req.body.deviceid}`);
        else {
            sql = `INSERT INTO reg_rider VALUES ("${req.body.mobno}", "${req.body.rname}", "${req.body.deviceid}", "${password}")`;
            ConnectDB.query(sql, (err, result) => {
                if (!err) return res.send(`registered ${req.body.mobno}`);
                return res.status(406).send(`faild to register ${req.body.mobno}`);
            });
        }
    });

});



module.exports = router;