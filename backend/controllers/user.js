const User = require("../models/User");
const fs = require('fs');
const path = require('path');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const create = (req, res) => {
    
    //Recoger parametros por post
    let param = req.body;

    if(!(param.correo && param.password && param.nombre && param.apellidos && param.rol)){
        res.status(400).send("All input is required");
    }

    const antiguoUsuario = User.findOne({correo: param.correo});

    if(antiguoUsuario){
        return res.status(409).send("User Already Exist. Please Login");
    }

    encryptedpassword = bcrypt.hashSync(param.password, 10);

    param.password = encryptedpassword;

    console.log("param" + param.nombre);

    //Crear objeto de usuario
    let user = new User(param);

    const token = jwt.sign(
        {user_id: user._id, email},
        process.env.TOKEN_KEY,
        {
            expiresIn: "2h",
        }
    );

    user.token = token;

    //Asignar valores al objeto de usuario
    user.nombre = param.nombre;
    user.password = param.password;

    console.log(user);
    //Guardar el usuario en la base de datos
    user.save((error, userStored) => {
        if(error || !userStored){
            return res.status(404).json({
                status:"error",
                mensaje:"El usuario no se ha podido guardar"
            });
        }
        return res.status(200).json({
            status:"success",
            usuario: userStored,
            mensaje:"El usuario se ha guardado"
        });
    }
    );

}

const index = (req, res) => {
    // Return all users
    User.find({}, (error, users) => {
        if(error || !users){
            return res.status(404).json({
                status:"error",
                mensaje:"El usuario no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status:"success",
            usuario: users,
            mensaje:"El usuario se ha encontrado"
        });
    }
    );
}
const get = (req, res) => {
    const id = req.params.id;
    User.findById(id, (error, user) => {
        if(error || !user){
            return res.status(404).json({
                status:"error",
                mensaje:"El usuario no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status:"success",
            usuario: user,
            mensaje:"El usuario se ha encontrado"
        });
    });
}

const remove = (req, res) => {
    const id = req.params.id;
    User.findByIdAndDelete(id, (error, user) => {
        if(error || !user){
            return res.status(404).json({
                status:"error",
                mensaje:"El usuario no se ha podido eliminar"
            });
        }
        return res.status(200).json({
            status:"success",
            usuario: user,
            mensaje:"El usuario se ha eliminado"
        });
    });
}

const login = (req, res) => {
    const correo = req.body.correo;
    const password = req.body.password;
    console.log(correo);
    console.log(password);
    User.findOne({correo: correo, password: password}, (error, user) => {
        if(error || !user){
            return res.status(404).json({
                status:"error",
                mensaje:"El usuario no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status:"success",
            usuario: user,
            mensaje:"El usuario se ha encontrado"
        });
    }
    );

}


module.exports = {
    create, 
    get,
    remove,
    index,
    login
}