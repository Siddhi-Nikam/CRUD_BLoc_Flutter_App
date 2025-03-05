const express = require('express');
const connectDB = require('./config/db');
const userRoute = require('./routes/user_route');
const app = express();
const PORT = process.env.PORT || 5000;
const bodypaser = require('body-parser');

//DB connection
connectDB();

//middleware
app.use(bodypaser.json());

//routes
app.use('/api/users', userRoute);


// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
  });

