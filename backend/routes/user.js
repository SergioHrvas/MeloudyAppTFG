const express = require('express');
const multer = require('multer'); //Trabajar con subida de archivos
const router = express.Router();
// const upload = multer({ storage: storage })
const UserController = require('../controllers/user.js');

// Rutas asociadas a los usuarios
router.post("/create-user" , UserController.create);
router.get("/get-user/:id" , UserController.get);
router.delete("/delete-user/:id" , UserController.remove);
router.get("/get-users" , UserController.index);

module.exports = router;
