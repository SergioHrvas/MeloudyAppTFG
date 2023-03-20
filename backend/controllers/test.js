const Test = require('../models/Test');
const Lesson = require('../models/Lesson');
const Progress = require('../models/Progress');
const Question = require('../models/Question');
const { model } = require('mongoose');


const create = (req, res) => {
    const preguntas = Lesson.findById(req.body.leccionId, (error, lesson) => {
        if (error || !lesson) {
            return res.status(404).json({
                status: "error",
                mensaje: "La lección no se ha podido encontrar"
            });
        }
        return lesson.preguntas;
    });

    const test = new Test(req.body);
    test.save((error, testSaved) => {
        if (error || !testSaved) {
            return res.status(404).json({
                status: "error",
                mensaje: "El test no se ha podido guardar correctamente"
            });
        }
        return res.status(200).json({
            status: "success",
            test: testSaved,
            mensaje: "El test se ha guardado correctamente"
        });
    });
}

const indexTests = async (req, res) => {
    console.log("- req.params.idUsuario: " + req.params.idUsuario);
    console.log("- req.params.idLeccion: " + req.params.idLeccion);
    Progress.find({ idUsuario: req.params.idUsuario, idLeccion: req.params.idLeccion }, async (error, progress) => {
        try {
            console.log(progress);
            if (error || progress.length == 0 || !progress) {
                return res.status(404).json({
                    status: "error",
                    mensaje: "El progreso no se ha podido encontrar"
                });
            }
            else {
                console.log("a");
                //Find all tests of a progress
                var tests = [];
                for (let i = 0; i < progress[0].tests.length; i++) {
                    try {
                        var test = await Test.findOne({ _id: progress[0].tests[i].toString() }, (error, test) => {
                            if (error || !test) {
                                return res.status(404).json({
                                    status: "error",
                                    mensaje: "El test no se ha podido encontrar"
                                });
                            }
                        }).clone();
                        tests.push(test);
                    } catch (error) {
                        console.log(error);
                    }
                }

                return res.status(200).json({
                    status: "success",
                    tests: tests,
                });
            }
        } catch (error) {
            console.log(error);
        }
        }
    );
}


const index = (req, res) => {
    // Return all tests
    Test.find({}, (error, tests) => {
        if (error || !tests) {
            return res.status(404).json({
                status: "error",
                mensaje: "El test no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            test: tests,
        });
    }
    );
}

const get = (req, res) => {
    Test.findById(id, (error, test) => {
        if (error || !test) {
            return res.status(404).json({
                status: "error",
                mensaje: "El test no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            test: test,
            mensaje: "El test se ha encontrado"
        });
    }
    );
}





const remove = (req, res) => {
    const id = req.params.id;
    Test.findByIdAndDelete(id, (error, test) => {
        if (error || !test) {
            return res.status(404).json({
                status: "error",
                mensaje: "El test no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            test: test,
            mensaje: "El test se ha encontrado"
        });
    }
    );
}

module.exports = {
    create,
    index,
    get,
    remove,
    indexTests
}
