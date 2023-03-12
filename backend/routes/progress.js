const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth'); //Trabajar con subida de archivos
const ProgressController = require('../controllers/progress.js');

// Rutas asociadas a los usuarios
// router.get("/get-questions", QuestionController.index);
router.post("/create-test-and-progress", ProgressController.create);
router.get("/get-tests-progress/:idUsuario/:idLeccion", ProgressController.indexTests);
// router.get("/get-question/:id", auth, QuestionController.get);
// router.put("/update-question/:id", auth, QuestionController.update);
// router.delete("/delete-question/:id", auth, QuestionController.remove);

module.exports = router;