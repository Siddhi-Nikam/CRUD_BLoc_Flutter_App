const express = require('express');
const userController = require('../controller/userController');
const router = express.Router();

router.post('/createUser', userController.createUser);
router.get('/getUsers', userController.getUsers);
router.get('/getUserById/:id', userController.getUserById);
router.put('/updateUser/:id', userController.updateUser);
router.delete('/deleteUser/:id', userController.deleteUser);

module.exports = router;