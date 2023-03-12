const Progress = require("../models/Progress");
const Test = require("../models/Test");
const { ObjectId } = require('mongodb');
const fs = require('fs');
const path = require('path');



const create = (req, res) => {
    let param = req.body;

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


const indexTests = async (req, res) => {
    Progress.find({ idUsuario: req.params.idUsuario, idLeccion: req.params.idLeccion }, async (error, progress) => {
            if (error || !progress) {
            return res.status(404).json({
                status: "error",
                mensaje: "El progreso no se ha podido encontrar"
            });
        }
        //Find all tests of a progress
        var tests = [];
        for (let i = 0; i < progress[0].tests.length; i++) {
            try{
            var test = await Test.findOne({ _id: progress[0].tests[i].toString() }, (error, test) => {
                if (error || !test) {
                    return res.status(404).json({
                        status: "error",
                        mensaje: "El test no se ha podido encontrar"
                    });
                }
            }).clone();
            tests.push(test);
        }catch(error){
            console.log(error);
        }
        }

        return res.status(200).json({
            status: "success",
            tests: tests,
        });        
    }
    );
}


const index = (req, res) => {
    // Return all progress of a user
    Progress.find({ idUsuario: req.params.idUsuario }, (error, progress) => {
        if (error || !progress) {
            return res.status(404).json({
                status: "error",
                mensaje: "El progreso no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            progreso: progress,
        });
    }
    );
}






module.exports = {
    create,
    index,
    indexTests
};