const User = require("../models/User");
const fs = require('fs');
const path = require('path');
const bcrypt = require('bcrypt');
const { generateToken } = require('../services/jwt');

const create = async (req, res) => {
    //Recoger parametros por post
    let param = req.body;

    try {
        if (!(param.correo && param.password && param.nombre && param.apellidos && param.rol)) {
            res.status(400).send("All input is required");
        }


        encryptedpassword = bcrypt.hashSync(param.password, 10);

        param.password = encryptedpassword;


        //Crear objeto de usuario
        let user = new User(param);

        const token = await generateToken(user._id);

        //Asignar valores al objeto de usuario
        user.password = param.password;

        console.log(user);
        console.log(token);
        
        //Guardar el usuario en la base de datos
        user.save((error, userStored) => {
            if (error || !userStored) {
                return res.status(404).json({
                    status: "error",
                    mensaje: "El usuario no se ha podido guardar"
                });
            }
            return res.status(200).json({
                status: "success",
                usuario: userStored,
                token: token,
                expiresIn: 14400,
                mensaje: "El usuario se ha guardado"
            });
        }
        );
    }
    catch (error) {
        console.log(error);

    }

}

const index = (req, res) => {
    // Return all users
    User.find({}, (error, users) => {
        if (error || !users) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            usuario: users,
            mensaje: "El usuario se ha encontrado"
        });
    }
    );
}
const get = (req, res) => {
    const id = req.params.id;
    User.findById(id, (error, user) => {
        if (error || !user) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            usuario: user,
            mensaje: "El usuario se ha encontrado"
        });
    });
}

const remove = (req, res) => {
    const id = req.params.id;
    User.findByIdAndDelete(id, (error, user) => {
        if (error || !user) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido eliminar"
            });
        }
        return res.status(200).json({
            status: "success",
            usuario: user,
            mensaje: "El usuario se ha eliminado"
        });
    });
}

const login = async (req, res) => {
    const correo = req.body.correo;
    const password = req.body.password;

    const user = await User.findOne({ correo: correo });
    const token = await generateToken(user._id);


    console.log(correo);
    console.log(password);
    User.findOne({ correo: correo }, (error, user) => {
        if (error || !user) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido encontrar"
            });
        }

        if (user) {
            bcrypt.compare(password, user.password, (error, result) => {
                if (result) {
                    return res.status(200).json({
                        status: "success",
                        usuario: user,
                        token: token,
                        expiresIn: 14400,
                        mensaje: "El usuario se ha encontrado"
                    });
                }
                else {
                    return res.status(404).json({
                        status: "error",
                        mensaje: "El usuario no se ha podido identificar"
                    });
                }
            }
            );

        }
        else {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido encontrar"
            });
        }
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