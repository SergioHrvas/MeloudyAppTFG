const mongoose = require('mongoose');

const connectDB = async() => {
    try{
        await mongoose.connect("mongodb+srv://sergiohervas:contra123@cluster0.jfdn9f2.mongodb.net/meloudydb?retryWrites=true&w=majority", {keepAlive: true, keepAliveInitialDelay: 300000});
        console.log("Conectado a la base de datos");
        
    }catch(error){
        console.log(error);
        throw new Error('Error a la hora de iniciar la BD');
    }
}

module.exports = {
    connectDB
}