const {Schema, model} = require('mongoose');

const TestSchema = Schema({
    leccionId: {
        type: Schema.Types.ObjectId,
        ref: 'Lesson',
        required: true
    },
    preguntas: [{
        preguntaId:{
            type: Schema.Types.ObjectId,
        ref: 'Question',
        required: true
        },
        respuesta: {
            type: String,
            required: true,
        },
        correcta: {
            type: Boolean,
            required: true,
        }
    }],
    
});

module.exports = model('Test', TestSchema);