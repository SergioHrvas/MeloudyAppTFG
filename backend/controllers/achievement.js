const Achievement = require('../models/Achievement');

const create = (req, res) => {
    const achievement = new Achievement(req.body);
    achievement.save((error, achievement) => {
        if (error || !achievement) {
            return res.status(404).json({
                status: "error",
                mensaje: "El logro no se ha podido crear"
            });
        }
        return res.status(200).json({
            status: "success",
            logro: achievement,
            mensaje: "El logro se ha creado"
        });
    }
    );

}

const index = (req, res) => {
    // Return all achievement
    Achievement.find({}, (error, achievements) => {
        if (error || !achievements) {
            return res.status(404).json({
                status: "error",
                mensaje: "Los logros no se han podido encontrar"
            });
        }
        return res.status(200).json({
            status: "success",
            logros: achievements,
            mensaje: "Los logros se han encontrado"
        });
    }
    );

}

const indexUser = (req, res) => {
    //Return all achievement of a user
    const id = req.params.idUser;
    User.findById(id, (error, user) => {
        if (error || !user) {
            return res.status(404).json({
                status: "error",
                mensaje: "El usuario no se ha podido encontrar"
            });
        }

        logros = user.logros;

        //find all logros and return
        Achievement.find({}, (error, achievements) => {
            if (error || !achievements) {
                return res.status(404).json({
                    status: "error",
                    mensaje: "Los logros no se han podido encontrar"
                });
            }
            return res.status(200).json({
                status: "success",
                logros: achievements,
                mensaje: "Los logros se han encontrado"
            });
        }
        );

    });
}

const remove = (req, res) => {
    const id = req.params.id;

    Achievement.findByIdAndDelete(id, (error, achievement) => {
        if (error || !achievement) {
            return res.status(404).json({
                status: "error",
                mensaje: "El logro no se ha podido eliminar"
            });
        }
        return res.status(200).json({
            status: "success",
            logro: achievement,
            mensaje: "El logro se ha eliminado"
        });
    }
    );
    
}


const update = (req, res) => {
    const id = req.params.id;

    Achievement.findByIdAndUpdate(id, req.body, { new: true }, (error, achievement) => {
        if (error || !achievement) {
            return res.status(404).json({
                status: "error",
                mensaje: "El logro no se ha podido actualizar"
            });
        }
        return res.status(200).json({
            status: "success",
            logro: achievement,
            mensaje: "El logro se ha actualizado"
        });
    }
    );
}



module.exports = {
    create,
    index,
    indexUser,
    remove,
    update
}
