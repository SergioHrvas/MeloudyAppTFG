const User = require("../models/User");
const Cookies = require("universal-cookie");
const fs = require('fs');
const path = require('path');

const cookies = new Cookies();

const create = (req, res) => {
    
    //Recoger parametros por post
    let param = req.body;

    //Crear objeto usuario y se asignan parámetros automáticamente
    const user = new User(param);

    console.log(param);
    //Guardar el objeto en la base de datos
    user.save((error, userSaved) => {
        if(error || !userSaved){
            return res.status(404).json({
                status:"error",
                mensaje:"El usuario no se ha podido guardar correctamente"
            });
        }
        return res.status(200).json({
            status:"success",
            usuario: userSaved,
            mensaje:"El usuario se ha guardado correctamente"
        });

    }); 

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


module.exports = {
    create, 
    get,
    remove
}