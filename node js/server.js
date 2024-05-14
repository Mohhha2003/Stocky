const app = require('./app');
const connectDb = require('./config/db');

app.listen(3000,"192.168.1.7",()=>{
    console.log("Server is running on port 3000");
    connectDb();
})

