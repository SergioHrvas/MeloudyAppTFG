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
    num_aciertos: {
        type: Number,
        required: true
    },
    num_aciertos_unica: {
        type: Number,
        required: true
    },
    num_aciertos_multiple: {
        type: Number,
        required: true
    },
    num_aciertos_texto: {
        type: Number,
        required: true
    },
    num_aciertos_micro: {
        type: Number,
        required: true
    },


    

});

module.exports = model('Test', TestSchema);