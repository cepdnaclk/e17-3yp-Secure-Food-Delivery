const restaurant = require('./routes/restaurant');
const config = require('config');
const users = require('./routes/users');
const auth = require('./routes/auth');
const orderHandle = require('./routes/orderhandle');
const orderAccess = require('./routes/orderaccess');

const express = require('express');
const https = require('https');
const fs = require('fs');

let key = fs.readFileSync(__dirname + '/./certs/selfsigned.key');
let cert = fs.readFileSync(__dirname + '/./certs/selfsigned.crt');
let options = { key: key, cert: cert };

const app = express();

if (!config.get('jwtPrivateKey')) {
    console.log('fatal error: jwtPrivateKey is not defined');
    process.exit(1);
}

app.use(express.json());
app.use('/api/restaurant', restaurant);
app.use('/api/users', users);
app.use('/api/auth', auth);
app.use('/api/order_handle', orderHandle);
app.use('/api/order_access', orderAccess);

let server = https.createServer(options, app);
const port = process.env.PORT || 3000;
server.listen(port, () => console.log(`https server listen on ${port}`));