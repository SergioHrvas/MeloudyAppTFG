const { Schema, model } = require('mongoose');

// El esquema define la estructura de los documentos de la colección
// El modelo es la clase que se utiliza para crear documentos de la colección

// Campos de Usuario y su tipo

const ProgressSchema = Schema({
    test: [{
        required: true,
        type: Schema.Types.ObjectId,
        ref: 'Test'
    }],

});

module.exports = model('Progress', ProgressSchema);