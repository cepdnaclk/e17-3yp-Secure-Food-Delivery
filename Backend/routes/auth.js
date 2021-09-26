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

    //verify whether rider has registered
    //send back jwt token
    let sql = `SELECT * FROM reg_rider WHERE reg_rider.mobNo = "${req.body.mobno}"`;
    ConnectDB.query(sql, async (err, result) => {
        if (!result.length | err) return res.status(400).send("invalid mobile number or password");
        else {
            bcrypt.compare(req.body.password, result[0].rpassword).then((result) => {
                if (!result) return res.status(400).send("invalid mobile number or password");
                else {
                    const token = jwt.sign({ mobno: req.body.mobno, role: "rider" }, config.get('jwtPrivateKey'));
                    return res.send(token);
                }
            });
        }
    });
});

module.exports = router;