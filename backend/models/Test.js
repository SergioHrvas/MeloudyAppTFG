const {Schema, model} = require('mongoose');

const TestSchema = Schema({
    idLeccion: {
        type: Schema.Types.ObjectId,
        ref: 'Lesson',
        required: true
    },
    preguntas: [{
        idPregunta:{
            type: Schema.Types.ObjectId,
            ref: 'Question',
            required: true
        },
        respuestas: [{
            type: String,
            //required: true,
        }],
    }],
    aprobado: {
        type: Boolean,
        required: true
    },
    fecha_creacion: {
        type: Date,
        default: Date.now
    },

    

});

module.exports = model('Test', TestSchema);