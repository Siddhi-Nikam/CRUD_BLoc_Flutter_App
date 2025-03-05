const User = require('../model/userModel'); // Use capital 'U' for models

// Create a new user
createUser = async (req, res) => {
    try {
        const newUser = new User(req.body);
        await newUser.save();
        res.status(201).json(newUser);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

// Get all users
getUsers = async (req, res) => {
    try {
        const users = await User.find();
        res.status(200).json(users);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

// Get user by ID
getUserById = async (req, res) => {
    try {
        const user = await User.findById(req.params.id);
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }
        res.status(200).json(user); // ✅ Fixed missing response
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

// Update user by ID
updateUser = async (req, res) => {
    try {
        const user = await User.findByIdAndUpdate(req.params.id, req.body, {
            new: true,
            runValidators: true
        });
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }
        res.status(200).json(user); // ✅ Fixed missing response
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

// Delete user by ID
deleteUser = async (req, res) => {
    try {
        const user = await User.findByIdAndDelete(req.params.id); // ✅ Fixed incorrect method
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }
        res.status(200).json({ message: "User deleted successfully" }); // ✅ Added response
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

module.exports = {
    createUser,
    getUsers,
    getUserById,
    updateUser,
    deleteUser
};
