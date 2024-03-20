const express = require("express");
const MongoStore = require("connect-mongo");
const flash = require("connect-flash");
const router = require("./routers/router");
const fileUpload = require("express-fileupload");
const path = require("path");

const cors = require("cors");
const app = express();

app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(
  fileUpload({
    createParentPath: true,
  })
);

app.use(express.static("public"));

app.use(
  "/images",
  express.static(path.join(__dirname, "./public/attachments"))
);

app.use(cors());

app.set("views", "views");

app.use("/api", router);
module.exports = app;
