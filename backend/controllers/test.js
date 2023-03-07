const Test = require('../models/Test');
const Lesson = require('../models/Lesson');
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

    //extraer 10 preguntas aleatorias 
    const preguntasAleatorias = preguntas.sort(() => Math.random() - 0.5).slice(0, 10);

    //crear un test con las preguntas aleatorias
    req.body.preguntas = preguntasAleatorias;

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
    remove
}
