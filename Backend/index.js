const restaurant = require('./routes/restaurant');
const config = require('config');
const users = require('./routes/users');
const auth = require('./routes/auth');
const orderHandle = require('./routes/orderhandle');
const express = require('express');
const app = express();

if (!config.get('jwtPrivateKey')) {
    console.log('fatal error: jwtPrivateKey is not defined');
    process.exit(1);
}

app.use(express.json());
app.use('/api/restaurant', restaurant);
app.use('/api/users', users);
app.use('/api/auth', auth);
app.use('/api/orderHandle', orderHandle);

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`server listen on ${port}`));