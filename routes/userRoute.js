const express = require('express');
const router = express.Router();
const { signUpValidation, rolesValidation, loginValidation } = require('../helpers/validation');
const userController = require('../controllers/userController');
const roleController = require('../controllers/roleController');
const getTestsController = require('../controllers/getTestsController');

router.post('/register', signUpValidation, userController.register);
router.post('/addRole', rolesValidation, roleController.addRole);
router.post('/login', loginValidation, userController.login);
router.get('/getUser', userController.getUser);
router.get('/getTests', getTestsController.getTests);
router.post('/changeStatus/:id', userController.changeStatus);

// router.get('/getTests', getTestsController.getTests);

module.exports = router;