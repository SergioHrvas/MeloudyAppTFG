const Lesson = require("../models/User");
const fs = require('fs');
const path = require('path');

const create = (req, res) => {

    //Recoger parametros por post
    let param = req.body;

    //Crear objeto usuario y se asignan parámetros automáticamente
    const lesson = new Lesson(param);

    console.log(param);
    //Guardar el objeto en la base de datos
    lesson.save((error, lessonSaved) => {
        if (error || !lessonSaved) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido guardar correctamente"
            });
        }
        return res.status(200).json({
            status: "success",
            usuario: lessonSaved,
            mensaje: "El usuario se ha guardado correctamente"
        });

    });

}

const index = (req, res) => {
    // Return all users
    Lesson.find({}, (error, lessons) => {
        if (error || !lessons) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            usuario: lessons,
            mensaje: "El usuario se ha encontrado"
        });
    }
    );
}


const get = (req, res) => {
    Lesson.findById(id, (error, lesson) => {
        if (error || !lesson) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            usuario: lesson,
            mensaje: "El usuario se ha encontrado"
        });
    }
    );
}

const remove = (req, res) => {
    const id = req.params.id;
    Lesson.findByIdAndDelete(id, (error, lesson) => {
        if (error || !lesson) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            usuario: lesson,
            mensaje: "El usuario se ha encontrado"
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

