const { check } = require('express-validator');

exports.signUpValidation = [
    check('name', 'name is required').not().isEmpty(),
    check('email', 'Please enter a valid mail').isEmail().normalizeEmail({ gmail_remove_dots: true}),
    check('phone', 'Please enter a valid phone number').isMobilePhone('any',{ strictMode: false}),
    check('username', 'Username is required').not().isEmpty(),
    check('password', 'Password is required').not().isEmpty(),
    check('role', 'Role is required').not().isEmpty(),
    // check('status', 'Status is required').not().isEmpty(),
]

exports.rolesValidation = [
    check('role', 'role is required').not().isEmpty(),
]

exports.loginValidation = [
    check('username', 'username is required').not().isEmpty(),
    check('password', 'Password is required').not().isEmpty(),
]