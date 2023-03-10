const Progress = require("../models/Progress");
const Test = require("../models/Test");
const { ObjectId } = require('mongodb');
const fs = require('fs');
const path = require('path');



const create = (req, res) => {
    console.log("aaaaaaaaaa");
    let param = req.body;
    console.log(param);

    //Creamos un test
    const test = new Test(param);

    //Guardamos el test
    test.save((error, testSaved) => {
        if (error || !testSaved) {
            return res.status(404).json({
                status: "error",
                mensaje: "El test no se ha podido guardar correctamente"
            });
        }


        testSaved = testSaved._id;

        //buscamos la leccion en el progreso
        Progress.findOne({ idUsuario: param.idUsuario, idLeccion: param.idLeccion }, (error, progress) => {
            if (!progress || error) {
                //si no existe el progreso, lo creamos
                progress = new Progress();
                progress.idUsuario = ObjectId(param.idUsuario);
                progress.idLeccion = ObjectId(param.idLeccion);
                console.log(progress.idLeccion)
                console.log(progress.idUsuario)
                progress.tests = [];
                progress.tests.push(testSaved);

                //Guardamos el progreso
                progress.save((error, progressSaved) => {
                    if (error || !progressSaved) {
                        return res.status(404).json({
                            status: "error",
                            mensaje: "El progreso no se ha podido guardar correctamente"
                        });
                    }
                    return res.status(200).json({
                        status: "success",
                        progreso: progressSaved,
                        test: testSaved,
                        mensaje: "El progreso se ha guardado correctamente"
                    });
                });
            }
            else {
                progress.tests.push(testSaved);
                console.log(progress);
                //guardamos el progreso
                progress.save((error, progressSaved) => {
                    if (error || !progressSaved) {
                        return res.status(404).json({
                            status: "error",
                            mensaje: "El progreso no se ha podido actualizar correctamente"
                        });
                    }
                    return res.status(200).json({
                        status: "success",
                        progreso: progressSaved,
                        test: testSaved,
                        mensaje: "El progreso se ha actualizado correctamente"

                    });


                });
            }


        });

    });



}



module.exports = {
    create,
};