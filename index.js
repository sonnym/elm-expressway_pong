var path = require("path");

var server = require("elm-expressway/lib/server");
var socket = require("elm-expressway/lib/socket");

var basePath = path.resolve(process.cwd());
var filename = path.resolve(basePath, "Pong", "Server.elm");

var pongSocketConfig = {
  filename: filename,
  basePath: basePath,
  portDefaults: {
    receiveInput: {
      space: false,
      dir1: 0,
      dir2: 0,
      delta: 0.0
    }
  },

  onConnection: onConnection
};

var pongSocket = socket(pongSocketConfig);

pongSocket(server);

server.listen(8000, "0.0.0.0");

function onConnection(pongServer) {
  return function(connection) {
    pongServer.emitter.on("sendGameState", function(gameState) {
      connection.write(gameState);
    });

    connection.on("data", function(rawInput) {
      pongServer.emitter.emit("receiveInput", JSON.parse(rawInput));
    });

    connection.on("close", function() { });
  };
}
