const Lesson = require("../models/Lesson");
const fs = require('fs');
const path = require('path');
const Progress = require("../models/Progress");
const Test = require("../models/Test");
const create = (req, res) => {

    //Recoger parametros por post
    let param = req.body;

    //Crear objeto usuario y se asignan parámetros automáticamente
    const lesson = new Lesson(param);

    //Guardar el objeto en la base de datos
    lesson.save((error, lessonSaved) => {
        if (error || !lessonSaved) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido guardar correctamente"
            });
        }
        return res.status(200).json({
            status: "success",
            leccion: lessonSaved,
            mensaje: "El usuario se ha guardado correctamente"
        });

    });

}


const index = (req, res) => {
    // Return all users
    Lesson.find({}, (error, lessons) => {
        if (error || !lessons) {
            return res.status(404).json({
                status: "error",
                mensaje: "La lección no se ha podido encontrar"
            });
        }
        else {

            var tests = [];

            Progress.find({ idUsuario: req.params.id }, async (error, progress) => {
                try{
                if (error || !progress) {
                    return res.status(404).json({
                        status: "error",
                        mensaje: "El progreso no se ha podido encontrar"
                    });
                }

            
                else {  
                    var progresos = [];

                //Para cada progreso buscar el número de tests aprobados
                for (let i = 0; i < progress.length; i++) {
                    var test = progress[i].tests;
                    var cuenta = 0;
                    for (let j = 0; j < test.length; j++) {
                        try{
                            //Buscar test
                        await Test.findOne({ _id: test[j].toString() }, (error, test) => {
                                console.log(test.aprobado);

                            if (error || !test) {
                                return res.status(404).json({
                                    status: "error",
                                    mensaje: "El test no se ha podido encontrar"
                                });
                            }
                            else {
                                if (test.aprobado) {
                                    tests.push(test);
                                    cuenta++;
                                    console.log("a");
                                }
                            }
                        }).clone();


                    }
                    catch (error){
                        console.log(error);
                    }
                    }
                    progresos.push({
                        idLeccion: progress[i].idLeccion,
                        testsAprobados: cuenta
                    });
                    console.log(progresos[i].testsAprobados);
                }



                return res.status(200).json({
                    status: "success",
                    cuenta: progresos,
                    progreso: progress,
                
                    leccion: lessons,
                    mensaje: "Las lecciones se ha encontrado"
                });
            }
        }
        catch(error){
            console.log(error);
        }


            }
            );
        }
    }

    );
}


const get = (req, res) => {
    Lesson.findById(id, (error, lesson) => {
        if (error || !lesson) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            usuario: lesson,
            mensaje: "El usuario se ha encontrado"
        });
    }
    );
}

const remove = (req, res) => {
    const id = req.params.id;
    Lesson.findByIdAndDelete(id, (error, lesson) => {
        if (error || !lesson) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            usuario: lesson,
            mensaje: "El usuario se ha encontrado"
        });
    }
    );
}

module.exports = {
    create,
    index,
    get,
    remove
}

