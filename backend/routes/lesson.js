const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth'); //Trabajar con subida de archivos
const LessonController = require('../controllers/lesson.js');

// Rutas asociadas a los usuarios
router.get("/get-lessons/:id", auth, LessonController.index);
//router.post("/create-lesson", auth, LessonController.create);
// router.get("/get-lesson/:id", auth, LessonController.get);
// router.put("/update-lesson/:id", auth, LessonController.update);    
// router.delete("/delete-lesson/:id", auth, LessonController.delete);



module.exports = router;
