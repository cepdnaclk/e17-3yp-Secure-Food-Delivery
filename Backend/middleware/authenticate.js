const jwt = require('jsonwebtoken');
const config = require('config');

function authen(req, res, next) {
    const token = req.header('x-authtoken');
    if (!token) return res.status(401).send('access denied. no web token parsed');

    try {
        const decodeToken = jwt.verify(token, config.get('jwtPrivateKey'));
        req.user = decodeToken; //to access mobno; req.user.mobno
        next();
    }
    catch (excepction) {
        res.status(400).send('invalid token');
    }
}

module.exports = authen;