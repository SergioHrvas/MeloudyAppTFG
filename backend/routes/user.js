const express = require('express');
const router = express.Router();
const UserController = require('../controllers/user.js');
const auth = require('../middleware/auth'); 

// Rutas asociadas a los usuarios
router.post("/registro", UserController.create);
router.post("/login" , UserController.login);

router.get("/get-user/:id" , auth, UserController.get);
router.get("/get-users" , UserController.index);

router.delete("/delete-user/:id", auth, UserController.remove);
module.exports = router;
