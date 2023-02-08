const express = require('express');
const cors = require('cors');

function createServer() {
    const app = express();

    //Configuración de cors middleware
    app.use(cors());

    //Para trabajar con las peticioens HTTP
    app.use(express.json());                            //content-type app/json
    app.use(express.urlencoded({ extended: true }));       //content-type app/x-www-form-urlencoded

    //Conectar las rutas
    const userRoutes = require('./routes/user');
    // const rutas_menu = require('./routes/menu');
    // const rutas_tarea = require('./routes/tareasDia');
    // const rutas_material = require('./routes/material');

    app.use("/api/user", userRoutes);
    // app.use("/api/menus", rutas_menu);
    // app.use("/api/tareas", rutas_tarea);
    // app.use("/api/materials", rutas_material);

    return app;
}
//Crear servidor node


module.exports = createServer;