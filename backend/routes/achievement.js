const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth'); //Trabajar con subida de archivos
const AchievementController = require('../controllers/achievement.js');

// Rutas asociadas a los usuarios
router.get("/get-achievement", AchievementController.index);
router.get("/get-questions/:idLeccion", AchievementController.indexUser);
router.post("/create-question", auth, AchievementController.create);
//router.get("/get-question/:id", auth, AchievementController.get);
router.put("/update-question/:id", auth, AchievementController.update);
router.delete("/delete-question/:id", auth, AchievementController.remove);


module.exports = router;