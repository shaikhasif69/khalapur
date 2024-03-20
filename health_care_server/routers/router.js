const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");

router.get("/", (req, res) => {
  res.send("Hello there! this is our project!");
});

router.post("/user-login",userController.login);
router.post("/user-signup", userController.addUser)
module.exports = router;
