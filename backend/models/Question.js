const { Schema, model } = require('mongoose');

const QuestionSchema = Schema({
    tipo: {
        type: String,
        required: true,
        enum: ['unica', 'multiple', 'texto', 'microfono']
    },
    cuestion: {
        type: String,
        required: true
    },
    respuestascorrectas: [{
        type: String,
        required: true
    },],
    opciones: [{
        type: String,
        required: true
    },],
    imagen: {
        type: String,
        required: false
    },
    audio: {
        type: String,
        required: false
    },
    video: {
        type: String,
        required: false
    }
});

module.exports = model('Question', QuestionSchema);