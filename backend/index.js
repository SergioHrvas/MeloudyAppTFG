const express = require('express');
const {connectDB} = require('./database/conexion');
const cors = require('cors');
const createServer = require('./createServer');


console.log("App arrancada");

//conectar base de datos
connectDB();
const puerto = 5000;

//Crear servidor node
const app = createServer();

// Function to serve all static files
// inside public directory.
app.use(express.static('public'));
app.use('/images', express.static('images'));
//Crear servidor y escuchar peticiones http
app.listen(puerto, () => {
    console.log("Sever running on port " + puerto);
});