const Question = require('../models/Question');

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
    Question.find({}, (error, questions) => {
        if (error || !questions) {
            return res.status(404).json({
                status: "error",
                mensaje: "La pregunta no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            pregunta: questions,
        });
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


module.exports = {
    create,
    index,
    get,
    remove
}
