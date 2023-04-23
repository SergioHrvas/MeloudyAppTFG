const Question = require('../models/Question');
const Test = require('../models/Test');

const create = (req, res) => {
    const question = new Question(req.body);
    question.save((error, questionSaved) => {
        if (error || !questionSaved) {
            return res.status(404).json({
                status: "error",
                mensaje: "La pregunta no se ha podido guardar correctamente"
            });
        }
        return res.status(200).json({
            status: "success",
            pregunta: questionSaved,
            mensaje: "La pregunta se ha guardado correctamente"
        });
    });
}

const index = (req, res) => {
    // Return all questions
    console.log("ENTROS");
    Question.find({}, (error, questions) => {
        if (error || !questions) {
            return res.status(404).json({
                status: "error",
                mensaje: "La pregunta no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            preguntas: questions,
        });
    }
    );
}

const indexTest = (req, res) => {
    const idLeccion = req.params.idLeccion;
    Question.find({ leccion: idLeccion }, (error, questions) => {
        if (error || !questions) {
            return res.status(404).json({
                status: "error",
                mensaje: "Las preguntas no se han podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            preguntas: questions,
        });
    }
    );
}


const getquestions = async (req, res) => {
    const id = req.params.idTest;

    Test.findById(id, async (error, test) => {
        try {
            if (error || !test) {
                return res.status(404).json({
                    status: "error",
                    mensaje: "El test no se ha podido encontrar"
                });
            }
            var preguntas = [];
            for (let i = 0; i < test.preguntas.length; i++) {
                console.log("aa" + test.preguntas[i]);
                try {

                const element = await Question.findById(test.preguntas[i].idPregunta, (error, question) => {
                        if (error || !question) {
                            return res.status(404).json({
                                status: "error",
                                mensaje: "La pregunta no se ha podido encontrar"
                            });
                        }
                        // return question;

                }
                ).clone();
                preguntas.push(element);
            } catch (error) {
                console.log(error);
            }
            }
            return res.status(200).json({
                status: "success",
                test: test,
                preguntas: preguntas,
                mensaje: "El test se ha encontrado"
            });
    } catch (error) {
        console.log(error);
    }
    }
    );
}




const get = (req, res) => {
    Question.findbyId(id, (error, question) => {
        if (error || !question) {
            return res.status(404).json({
                status: "error",
                mensaje: "La pregunta no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            pregunta: question,
            mensaje: "La pregunta se ha encontrado"
        });
    }
    );
}

const remove = (req, res) => {
    const id = req.params.id;
    Question.findByIdAndDelete(id, (error, question) => {
        if (error || !question) {
            return res.status(404).json({
                status: "error",
                mensaje: "La pregunta no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            pregunta: question,
            mensaje: "La pregunta se ha encontrado"
        });
    }
    );
}


const update = (req, res) => {
    const id = req.params.id;

    Question.findByIdAndUpdate(id, req.body, { new: true }, (error, question) => {
        if (error || !question) {
            return res.status(404).json({
                status: "error",
                mensaje: "La pregunta no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            pregunta: question,
            mensaje: "La pregunta se ha encontrado"
        });
    }
    );
}



module.exports = {
    create,
    index,
    indexTest,
    get,
    getquestions,
    remove,
    update
}
