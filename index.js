var http = require("http");
var path = require("path");

var express = require("express");

process.env.NODE_ENV = process.env.NODE_ENV || "development";

/***/
var isProduction = (process.env.NODE_ENV === "production");
var port = (isProduction ? 80 : 8000);

/***/
var app = express();
var server = http.createServer(app);

app.use(express.static(path.join(__dirname, "public")));

server.listen(port, "0.0.0.0");
