const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth'); //Trabajar con subida de archivos
const QuestionController = require('../controllers/question.js');

// Rutas asociadas a los usuarios
router.get("/get-questions", QuestionController.index);
router.post("/create-question", auth, QuestionController.create);
router.get("/get-question/:id", auth, QuestionController.get);
// router.put("/update-question/:id", auth, QuestionController.update);
router.delete("/delete-question/:id", auth, QuestionController.remove);

module.exports = router;