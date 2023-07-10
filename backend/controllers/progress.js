const Progress = require("../models/Progress");
const Test = require("../models/Test");
const User = require("../models/User");
const Leccion = require("../models/Lesson");
const Achievement = require("../models/Achievement");

const { ObjectId } = require('mongodb');
const fs = require('fs');
const path = require('path');



const create = async (req, res) => {
    let param = req.body;

    //Creamos un test
    const test = new Test(param);

    //Guardamos el test
    test.save((error, testSaved) => {
        try {
            if (error || !testSaved) {
                return res.status(404).json({
                    status: "error",
                    mensaje: "El test no se ha podido guardar correctamente"
                });
            }
            else {

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
                        progress.completado = false;

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

                        var aprobados = 0;


                        
                            User.findOne({ _id: progress.idUsuario }, (error, user) => {
                                try {
                                    if (error || !user) {
                                        return res.status(404).json({
                                            status: "error",
                                            mensaje: "El usuario no se ha podido encontrar"
                                        });
                                    }
                                    else {
                                        Leccion.findOne({ _id: progress.idLeccion }, async (error, leccion) => {
                                            try {                                                
                                                var preguntasAcierto = 0;
                                                var preguntasAciertoUnica = 0;
                                                var preguntasAciertoMultiple = 0;
                                                var preguntasAciertoTexto = 0;
                                                var preguntasAciertoMicro = 0;

                                                for(var i = 0; i < progress.tests.length; i++){
                                                    await Test.findOne({ _id: progress.tests[i] }, async (error, test) => {
                                                        try {
                                                            if (error || !test) {
                                                                return res.status(404).json({
                                                                    status: "error",
                                                                    mensaje: "El test no se ha podido encontrar"
                                                                });
                                                            }
                                                            else {
                                                                aprobados++;
                                                                preguntasAcierto += test.num_aciertos;
                                                                preguntasAciertoUnica += test.num_aciertos_unica;
                                                                preguntasAciertoMultiple += test.num_aciertos_multiple;
                                                                preguntasAciertoTexto += test.num_aciertos_texto;
                                                                preguntasAciertoMicro += test.num_aciertos_micro;
                                                            }



                                                        } catch (error) {
                                                            console.log(error);
                                                        }
                                                    }
                                                    ).clone();
                                                }

                                                if (aprobados >= 3) {
                                                    progress.completado = true;
                                                }

                                                logros = Achievement.find({}, (error, logros) => {
                                                    try {
                                                        if (error || !logros) {
                                                            return res.status(404).json({
                                                                status: "error",
                                                                mensaje: "Los logros no se han podido encontrar"
                                                                });
                                                        }
                                                        else {

                                       //get all logros
                                                for(var i = 0; i < logros.length; i++){
                                                    if(logros[i].tipo == "preguntas"){
                                                        if(preguntasAcierto >= logros[i].condicion && !user.logros.includes(logros[i]._id)){
                                                            user.logros.push(logros[i]._id);
                                                        }
                                                    }
                                                    else if(logros[i].tipo == "preguntasunica"){
                                                        if(preguntasAciertoUnica >= logros[i].condicion && !user.logros.includes(logros[i]._id)){
                                                            user.logros.push(logros[i]._id);
                                                        }
                                                    }
                                                    else if(logros[i].tipo == "preguntasmultiple"){
                                                        if(preguntasAciertoMultiple >= logros[i].condicion && !user.logros.includes(logros[i]._id)){
                                                            user.logros.push(logros[i]._id);
                                                        }
                                                    }
                                                    else if(logros[i].tipo == "preguntastexto"){
                                                        if(preguntasAciertoTexto >= logros[i].condicion && !user.logros.includes(logros[i]._id)){
                                                            user.logros.push(logros[i]._id);
                                                        }
                                                    }
                                                    else if(logros[i].tipo == "preguntasmicro"){
                                                        if(preguntasAciertoMicro >= logros[i].condicion && !user.logros.includes(logros[i]._id)){
                                                            user.logros.push(logros[i]._id);
                                                        }
                                                    }

                                                    if(logros[i].condicion == ObjectId(param.idLeccion) && !user.logros.includes(logros[i]._id)){
                                                        user.logros.push(logros[i]._id);
                                                    }
                                                }

                                                user.save((error, userSaved) => {
                                                    if (error || !userSaved) {
                                                        return res.status(404).json({
                                                            status: "error",
                                                            mensaje: "El usuario no se ha podido actualizar correctamente"
                                                        });
                                                    }
                                                    else{
                                                        
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
                                                        }


                                                        );
                                                    }
                                                }
                                                );                                                        }
                                                    } catch (error) {
                                                        console.log(error);
                                                    }
                                                });


         
                                            } catch (error) {
                                                console.log(error);
                                            }
                                        });

                                    }
                                } catch (error) {
                                    console.log(error);
                                }


                            }
                            );




                    }


                });
            }
        } catch (error) {
            console.log(error);
        }

    });

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

const numAprobados = (req, res) => {
    // Return tests of progress with aprobados = true
    Progress.find({ idUsuario: req.params.idUsuario, idLeccion: req.params.idLeccion }, (error, progress) => {
        if (error || !progress) {
            return res.status(404).json({
                status: "error",
                mensaje: "El progreso no se ha podido encontrar"
            });
        }
        else {
            //Find all tests of a progress
            var tests = [];
            var num = 0;
            for (let i = 0; i < progress[0].tests.length; i++) {
                try {
                    var test = Test.findOne({ _id: progress[0].tests[i].toString() }, (error, test) => {
                        if (error || !test) {
                            return res.status(404).json({
                                status: "error",
                                mensaje: "El test no se ha podido encontrar"
                            });

                        }
                        else {
                            if (test.aprobado) {
                                tests.push(test);
                                num++;
                            }
                        }
                    });
                } catch (error) {
                    console.log(error);
                }
            }
            return res.status(200).json({
                status: "success",
                tests: tests,
                num: num,
            });
        }
    }
    );
}






module.exports = {
    create,
    index,
};