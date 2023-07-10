const Lesson = require("../models/Lesson");
const fs = require('fs');
const path = require('path');
const Progress = require("../models/Progress");
const Test = require("../models/Test");
const multer = require('multer');

const create = (req, res) => {
    //Recoger parametros por post
    let param = req.body;

    lesson = new Lesson(param);

    //Crear objeto lesson y se asignan parámetros automáticamente
    // const lesson = new Lesson(param);

    //Guardar el objeto en la base de datos
    lesson.save((error, lessonSaved) => {
        if (error || !lessonSaved) {
            return res.status(404).json({
                status: "error",
                mensaje: "La lección no se ha podido guardar correctamente"
            });
        }
        return res.status(200).json({
            status: "success",
            leccion: lessonSaved,
            mensaje: "La lección se ha guardado correctamente"
        });

    });
}


const index = async (req, res) => {
    // Return all users

    await Lesson.find({}, async (error, lessons) => {
        if (error || !lessons) {
            return res.status(404).json({
                status: "error",
                mensaje: "La lección no se ha podido encontrar"
            });
        }
        else {
            var tests = [];

            await Progress.find({ idUsuario: req.params.id }, async (error, progress) => {
                try{
                    if (error || !progress) {
                        return res.status(404).json({
                            status: "error",
                            mensaje: "El progreso no se ha podido encontrar",
                            leccion: lessons,
                        });
                    }
                    else {  
                        var tests = [];
                        //Para cada progreso buscar el número de tests aprobados
                        
                        for (let i = 0; i < progress.length; i++) {
                            var test = progress[i].tests;
                            var cuenta = 0;
                            try {
 
                                for (let j = 0; j < test.length; j++) {
                                    //Buscar test
                                    var a = await Test.findOne({ _id: test[j].toString() }, (error, test) => {
                                        try{
                                        if (error || !test) {
                                            return res.status(404).json({
                                                status: "error",
                                                mensaje: "El test no se ha podido encontrar"
                                            });
                                        }

                                        //return cuenta;
                                        }
                                        catch(error){
                                            console.log(error);
                                        }
                                    }).clone();
                        
                                    if(a.aprobado != undefined){
                                        if(a.aprobado == true)    
                                            cuenta++;
                                    }                            
                                }
                    
                                tests.push({
                                    idLeccion: progress[i].idLeccion,
                                    testsAprobados: cuenta
                                });
                            }
                            catch (error){
                                console.log(error);
                            }
                        }
                
                        return res.status(200).json({
                            status: "success",
                            tests: tests,
                            progreso: progress,
                        
                            leccion: lessons,
                            mensaje: "Las lecciones se ha encontrado"
                        });
                    }
                }
                catch(error){
                    console.log(error);
                }
            }).clone();
        }
    }).clone();
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
                mensaje: "La lección no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            leccion: lesson,
            mensaje: "La lección se ha eliminado correctamente",
        });
    }
    );
}

const update = (req, res) => {
    const id = req.params.id;
    const param = req.body;
    
     Lesson.findByIdAndUpdate(id, param, { new: true }, (error, lesson) => {
        if (error || !lesson) {
            return res.status(404).json({
                status: "error",
                mensaje: "La lección no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            leccion: lesson,
            mensaje: "La lección se ha actualizado correctamente",
        });
    }
    ); 
}



        





module.exports = {
    create,
    index,
    get,
    remove,
    update
}

