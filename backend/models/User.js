const {Schema, model} = require('mongoose');

// El esquema define la estructura de los documentos de la colección
// El modelo es la clase que se utiliza para crear documentos de la colección

// Campos de Usuario y su tipo

const UsuarioSchema = Schema({
    nombre: {
        type: String,
        required: true
    },
    username: {
        type: String,
        // required: true,
        unique: true,
        required: true
    },
    password: {
        type: String,
        required: true
    },
    apellidos: [{
        type: String,
        required: true
    }],
    fecha_nacimiento: {
        type: Date,
        
    },
    rol:{  //alumno, profesor o administrador
        type: String,
        required: true,
        enum: ['Usuario', 'Profesor', 'Admin']
    },
    foto:{ 
        type: String,
    },
    correo: {
        type: String,
        required: true,
        unique: true
    },
    token: {
        type: String,
    },
    logros: [{
        type: Schema.Types.ObjectId,
        ref: 'Logro'
    }],
});

module.exports = model('Usuario', UsuarioSchema);
/*
    . Usuario es el nombre del modelo ("el nombre del constructor y de la clase")
    . UsuarioSchema es el esquema que define como se comporta el modelo
    . "..." es el nombre de la colección de la base de datos
        . Por defecto se coge el nombre del modelo en minuscula y se pluraliza : Usuario => usuarios
        . Se puede especificar otro pero seguiremos esta convención
*/