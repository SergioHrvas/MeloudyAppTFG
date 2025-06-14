const { Schema, model } = require('mongoose');

const AchievementSchema = Schema({
    nombre: {
        type: String,
        required: true
    },
    descripcion: {
        type: String,
    },
    imagen: {
        type: String,
        required: true
    },    
    tipo
    : {
        type: String,
        required: true
    },
    condicion: {
        type: String,
        required: true
    },
    
});

module.exports = model('Achievement', AchievementSchema);