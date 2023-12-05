const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const app = express();
const userRouter = require('./routes/userRoute');
const port = 3000

require("dotenv").config();
require('./config/dbConnection.js');

app.use(cors());
app.use(express.json());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended:true}))

app.use('/api', userRouter);

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})