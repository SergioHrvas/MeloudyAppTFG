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
    const lessonRoutes = require('./routes/lesson');
    const questionRoutes = require('./routes/question');
    const testRoutes = require('./routes/test');

    app.use("/api/user", userRoutes);
    app.use("/api/lesson", lessonRoutes);
    app.use("/api/question", questionRoutes);
    app.use("/api/test", testRoutes);
    


    return app;
}
//Crear servidor node


module.exports = createServer;