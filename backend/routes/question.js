const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth'); //Trabajar con subida de archivos
const QuestionController = require('../controllers/question.js');

// Rutas asociadas a los usuarios
router.get("/get-questions", QuestionController.index);
router.get("/get-questions/:idLeccion", QuestionController.indexTest);
router.get("/get-questions-test/:idTest", QuestionController.getquestions);
router.post("/create-question", QuestionController.create);
//router.get("/get-question/:id", auth, QuestionController.get);
router.put("/update-question/:id", QuestionController.update);
router.delete("/delete-question/:id", QuestionController.remove);


module.exports = router;