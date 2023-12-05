const { validationResult } = require('express-validator');
const bcrypt = require('bcryptjs');

require("dotenv").config();
const db = require('../config/dbConnection');

const jwt = require('jsonwebtoken');
const JWT_SECRET = process.env.JWT_SECRET;

const register = (req,res) => {

    const errors = validationResult(req);

    if(!errors.isEmpty()){
        return res.status(400).json({
            errors: errors.array()
        })
    }

    db.query(`SELECT * FROM roles WHERE role = ${db.escape(req.body.role)}`,(err, result) => {
        if (err) {
            return res.status(500).send({
                "err in selecting role" : err
            })
        } else {
            if (!result || result.length === 0) {
                return res.status(404).send({
                    msg: "Role doesnot exist"
                })
            } else {
                bcrypt.hash(req.body.password, 10, (err, hash) => {
                    if(err){
                        return res.status(400).send({
                            "error in generating pw": err
                        })
                    } else {
                        const insertQuery = `
                            INSERT INTO users (name, email, phone, username, password, role)
                            VALUES (?, ?, ?, ?, ?, (SELECT id FROM roles WHERE role = ?))`

                        const insertValues = [
                            req.body.name,
                            req.body.email,
                            req.body.phone,
                            req.body.username,
                            hash,
                            req.body.role,
                            // req.body.status,
                        ];

                        db.query(insertQuery, insertValues, (err, result) => {
                            if(err){
                                return res.status(400).send({
                                    "err in insert query": err
                                })
                            } else {
                                return res.status(200).send({
                                    msg: "User added successfully"
                                })
                            }
                        })
                    
                    }
                })
            }
        }
    })
}

const login = (req,res) => {

    const errors = validationResult(req);
    // const { JWT_SECRET } = process.env.JWT_SECRET;
    // const JWT_SECRET = process.env.JWT_SECRET;
    // console.log("secret key is", JWT_SECRET);

    if(!errors.isEmpty()){
        return res.status(400).json({
            errors: errors.array()
        })
    }

    // console.log(`${req.body.username}`);
    // console.log(`${req.body.password}`);

    try {

        db.query(`SELECT * FROM users WHERE username = ${db.escape(req.body.username)}`,(err,result) => {
            if (err) {
                return res.status(400).send ({
                    "err in select query": err
                })
            } else {
                if(!result.length){
                    // console.log("invalid username or pw")
                    return res.status(400).send ({
                        "msg": "invalid username"
                    })
                }
            }
    
            //to check the status of the user
            const isStatus = result[0].status;      

            if(isStatus){
                bcrypt.compare(req.body.password, result[0]['password'], (bErr, bResult) => {
                    if (bErr) {
                        return res.status(400).send ({
                            "err in compare pw" : err
                        })
                    } 
                    
                    if(!bResult){
                        return res.status(400).send ({
                            msg : "user not found"
                        })
                    }
        
                    else {
                        // console.log(JWT_SECRET);
                        const token = jwt.sign({ 
                            id: result[0]['id'],
                            admin: result[0]['admin']
                        }, JWT_SECRET, { expiresIn : '1 day'})
        
                        return res.status(200).send({
                            msg : "Logged in",
                            token : token,
                            user : result[0]
                        })
                    }
                })
            } else {
                return res.status(400).send({
                    msg : "Your account has been disabled kindly contact admin for assistance",
                })
            }
        })


    } catch (error) {
        return res.status(400).send({
            "msg" : error
        })
    }

}

const getUser = (req,res) => {
    const authToken = req.headers.authorization.split(' ')[1];
    const decode = jwt.verify(authToken, JWT_SECRET);
    // console.log("decoded is",decode);

    db.query(`SELECT * FROM users where id=${decode.id}`, (err, result, fields) => {
        if(err) {
            return res.status(400).send({
                "err in decoding": err
            })
        }

        return res.status(200).send({
            success: true,
            data: result[0],
            message: "Fetched Successfully"
        })

    })
}

const changeStatus = (req,res) => {

    const userId = req.params["id"];
    console.log(userId);

    const query = `SELECT * FROM users where id=${userId} `;

    db.query(query,(err,result) => {
        // If error
        if(err) {
            return res.status(400).send({
                msg: err
            })
        }

        // Check user status
        let status = result[0].status;
        status = !result[0].status;

        // Change user status

        db.query(`UPDATE users SET status =${status}  WHERE id = ${userId} `, (err,result) => {
            if(err) {
                return res.status(400).send({
                    msg: err
                })
            } else {
                return res.status(200).send({
                    success: true,
                    message: "User status changed successfully",
                })
            }
        })

        



    })
}

module.exports = {
    register,login, getUser, changeStatus
}