const jwt = require('jsonwebtoken');

const config = process.env;

const verifyToken = (req, res, next) => {
    const token = req.body.auth || req.query.auth || req.headers['x-access-token'];
    console.log(token);
    if(!token){
        return res.status(403).send({ auth: false, message: 'No token provided.' });
    }
    try{
        const decoded = jwt.verify(token, config.JWTKEY);
        req.user = decoded;
        console.log(decoded);
        
    } catch (error){
        return res.status(500).send({ auth: false, message: 'Failed to authenticate token.' });
    }
    return next();
};

module.exports = verifyToken;