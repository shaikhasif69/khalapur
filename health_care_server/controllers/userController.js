const dotenv = require("dotenv");

dotenv.config();
const User = require("../models/User");

const jwt = require("jsonwebtoken");

exports.login = function (req, res) {
  console.log(req.body);
  let user = new User(req.body);
  user
    .login()
    .then(function (result) {
      let jwtSecretKey = process.env.JWT_SECRET_KEY;
      let data = {
        role: result.role,
        id: result._id,
      };
      const token = jwt.sign(data, jwtSecretKey);
      res.json({ token: token, user: result });
    })
    .catch(function (e) {
      console.log(e);
    });
};

exports.addUser = async function (req, res) {
  console.log(req.body);
  let user = new User(req.body);
  let data = await user.createUser();
  res.status(200).json({ data });
};

exports.getUserById = async function (req, res) {
    let user = new User()
    let data = await user.getUserById()
    res.json(data)
}



exports.getAllUsers = async function (req, res) {
  let users = new User();
  let data = await users.getAllUsers();
  res.status(201).json({ data: data });
};
