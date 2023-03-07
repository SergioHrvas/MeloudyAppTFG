const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth'); //Trabajar con subida de archivos
const TestController = require('../controllers/test.js');

// Rutas asociadas a los usuarios
router.get("/get-tests", auth, TestController.index);
router.post("/create-test", auth, TestController.create);
router.get("/get-test/:id", auth, TestController.get);
router.delete("/delete-test/:id", auth, TestController.remove);

module.exports = router;