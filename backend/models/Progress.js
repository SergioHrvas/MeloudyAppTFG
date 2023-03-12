const { Schema, model } = require('mongoose');

// El esquema define la estructura de los documentos de la colección
// El modelo es la clase que se utiliza para crear documentos de la colección

// Campos de Usuario y su tipo

const ProgressSchema = Schema({
    idUsuario: {
        type: Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    idLeccion: {
        type: Schema.Types.ObjectId,
        ref: 'Lesson',
        required: true
    },
    completado: {
        type: Boolean,
    },
    tests: [{
        type: Schema.Types.ObjectId,
        ref: 'Test'
    }],
    completado: {
        type: Boolean,
        required: true
    },


});

module.exports = model('Progress', ProgressSchema);