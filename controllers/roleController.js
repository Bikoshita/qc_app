const { validationResult } = require("express-validator");
const bcrypt = require("bcryptjs");

require("dotenv").config();
const db = require("../config/dbConnection");

const addRole = (req, res) => {
    // console.log("I am inside addRole api");
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
        return res.status(400).json({
            errors: errors.array(),
        });
    }

    db.query(
        `SELECT * FROM roles WHERE role = ${db.escape(req.body.role)};`,
        (err, result) => {
            if (result && result.length) {
                return res.status(409).send({
                    msg: "This role already exists",
                });
            } else {
                    const insertQuery = `INSERT INTO roles (role) VALUES (?);`;

                    const insertValues = [
                        req.body.role,
                    ];

                    db.query(insertQuery, insertValues, (err, result) => {
                        if (err) {
                            return res.status(400).send({
                                msg: err,
                            });
                        }

                        return res.status(200).send({
                            msg: "Role has been added successfully",
                        });
                    });
                
            }
        }
    );
};

module.exports = {
    addRole,
};
