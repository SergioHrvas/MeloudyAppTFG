const express = require('express');
const router = express.Router();
const UserController = require('../controllers/user.js');
const auth = require('../middleware/auth'); 

// Rutas asociadas a los usuarios
router.post("/registro", UserController.create);
router.get("/get-user/:id" , auth, UserController.get);
router.delete("/delete-user/:id", auth, UserController.remove);
router.get("/get-users" , UserController.index);
router.post("/login" , UserController.login);
module.exports = router;
