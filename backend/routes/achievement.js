const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth'); //Trabajar con subida de archivos
const AchievementController = require('../controllers/achievement.js');

// Rutas asociadas a los usuarios
router.get("/get-achievement", AchievementController.index);
router.get("/get-achievements/:idUser", AchievementController.indexUser);
router.post("/create-achievement",  AchievementController.create);
router.get("/get-achievement/:id",AchievementController.get);
router.put("/update-achievement/:id", AchievementController.update);
router.delete("/delete-achievement/:id", AchievementController.remove);


module.exports = router;