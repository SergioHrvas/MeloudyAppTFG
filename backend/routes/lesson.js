const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth'); //Trabajar con subida de archivos
const LessonController = require('../controllers/lesson.js');
const multer = require('multer');
var storage = multer.diskStorage({
    destination: function (req, file, cb) {
       cb(null, 'public/img');
    },
    filename: function (req, file, cb) {
       cb(null, file.originalname);
    }
 });

 var upload = multer({ storage: storage });
// Rutas asociadas a los usuarios
router.get("/get-lessons/:id", auth, LessonController.index);
router.post("/create-lesson", auth, LessonController.create);
// router.get("/get-lesson/:id", auth, LessonController.get);
// router.put("/update-lesson/:id", auth, LessonController.update);    
router.delete("/delete-lesson/:id", auth, LessonController.remove);
router.post("/upload-image", auth, upload.single('image'));



module.exports = router;
