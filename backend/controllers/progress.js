const Progress = require("../models/Progress");
const Test = require("../models/Test");

const fs = require('fs');
const path = require('path');

const create = (req, res) => {
    console.log("aaaaaaaaaa");
    let param = req.body;
    const progress = new Progress(param);
    console.log(param);
/*     progress.save((error, progressSaved) => {
        if (error || !progressSaved) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido guardar correctamente"
            });
        }
        return res.status(200).json({
            status: "success",
            progreso: progressSaved,
            mensaje: "El usuario se ha guardado correctamente"
        });

    }); */
    return res.status(200).json({
        status: "success",
        mensaje: "El test se ha encontrado"
    });
}

module.exports = {
    create,
};