var server = require("elm-expressway/lib/server");
var socket = require("./socket");

socket(server);

server.listen(8000, "0.0.0.0");
