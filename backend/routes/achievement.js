const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth'); //Trabajar con subida de archivos
const AchievementController = require('../controllers/achievement.js');

// Rutas asociadas a los usuarios
router.get("/get-achievement", AchievementController.index);
router.get("/get-achievements/:idUser", AchievementController.indexUser);
router.post("/create-achievement", auth, AchievementController.create);
//router.get("/get-question/:id", auth, AchievementController.get);
router.put("/update-achievement/:id", auth, AchievementController.update);
router.delete("/delete-achievement/:id", auth, AchievementController.remove);


module.exports = router;