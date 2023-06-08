const express = require('express');
const router = express.Router();
const UserController = require('../controllers/user.js');
const auth = require('../middleware/auth'); 

// Rutas asociadas a los usuarios
router.post("/registro", UserController.create);
router.post("/login" , UserController.login);

router.get("/get-user/:id" , UserController.get);
router.get("/get-users" , UserController.index);

router.delete("/delete-user/:id", UserController.remove);

router.put("/update-user/:id", UserController.update);

module.exports = router;
