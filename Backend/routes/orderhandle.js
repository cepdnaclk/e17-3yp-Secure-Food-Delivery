const authen = require('../middleware/authenticate');
const ConnectDB = require('../middleware/database');
const express = require('express');
const router = express.Router();

// sends ongoing orders for perticular rider's carrier
router.get('/list', authen, async (req, res) => {
    let mobno = req.user.mobno;

    let sql = `SELECT deviceID FROM reg_rider WHERE reg_rider.mobNo = "${mobno}"`;
    ConnectDB.query(sql, (err, result) => {
        if (err) return res.status(404);
        else {
            let deviceid = result[0];
            let sql = `CALL viewCurrentOrders("${deviceid}")`;
            ConnectDB.query(sql, (err, result) => {
                if (err) return res.status(400).send('db error');
                else {
                    return res.send(result[0]); // sends the ongoing ordersID
                }
            });
        }
    });
});

//router.get

module.exports = router;