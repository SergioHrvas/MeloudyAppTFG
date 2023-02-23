const jwt = require('jsonwebtoken');
require('dotenv').config();
const generateToken = (uid) => {
    return new Promise((resolve, reject) => {
        const payload = { uid };
        jwt.sign(payload, process.env.JWTKEY, {
            expiresIn: '4h'
        }, (err, token) => {
            if (err) {
                console.log(err);
                reject('No se pudo generar el token');
            } else {
                resolve(token);
            }
        });
    });
}

const verifyToken = (token) => {

    try {
        const { uid } = jwt.verify(token, process.env.JWTKEY);
        return [true, uid];
    }
    catch (error) {
        return [false, null];
    }

}

module.exports = {
    generateToken,
    verifyToken
}