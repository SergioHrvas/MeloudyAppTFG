const User = require("../models/User");
const fs = require('fs');
const path = require('path');
const bcrypt = require('bcrypt');
const { generateToken } = require('../services/jwt');
const Achievement = require("../models/Achievement");

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
                mensaje: "Los usuarios no se han podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            usuario: users,
            mensaje: "Los usuarios se han encontrado"
        });
    }
    );
}


//Get user and his achievements
const get = (req, res) => {
    //Return all achievement of a user
    const id = req.params.id;
    User.findById(id, (error, user) => {
        if (error || !user) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido encontrar"
            });
        }

        logros = user.logros;

        //find logros of user and return
        Achievement.find({ _id: { $in: logros } }, (error, achievements) => {
            if (error || !achievements) {
                return res.status(404).json({
                    status: "error",
                    mensaje: "Los logros no se han podido encontrar"
                });
            }

            return res.status(200).json({
                status: "success",
                logros: achievements,
                usuario: user,
                mensaje: "Los logros se han encontrado"
            });
        }

        
        );

    }
    );

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

const update = (req, res) => {
    const id = req.params.id;

    param = req.body;

    if (param.password != null) {
        encryptedpassword = bcrypt.hashSync(param.password, 10);
        param.password = encryptedpassword;
    }

    User.findByIdAndUpdate(id, param, { new: true }, (error, user) => {
        if (error || !user) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido actualizar"
            });
        }
        return res.status(200).json({
            status: "success",
            usuario: user,
            mensaje: "El usuario se ha actualizado"
        });
    });
}



module.exports = {
    create,
    get,
    remove,
    index,
    login,
    update
}