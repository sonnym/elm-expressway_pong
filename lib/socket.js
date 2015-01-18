var path = require("path");

var sockjs = require("sockjs");
var Elm = require("elm-loader");

var sockjsOpts = { sockjs_url: "http://cdn.sockjs.org/sockjs-0.3.4.min.js" }
var socket = sockjs.createServer(sockjsOpts);

var basePath = path.resolve(__dirname, "..");
var filename = path.resolve(basePath, "Pong", "Server.elm");

var pongServer = Elm(filename, basePath, {
  receiveInput: {
    space: false,
    dir1: 0,
    dir2: 0,
    delta: 0.0
  }
});

module.exports.listen = function(server) {
  server.addListener("upgrade", function(_, res){
    res.end();
  });

  socket.on("connection", function(connection) {
    pongServer.emitter.on("sendGameState", function(gameState) {
      connection.write(JSON.stringify(gameState));
    });

    connection.on("data", function(rawInput) {
      pongServer.emitter.emit("receiveInput", JSON.parse(rawInput));
    });

    connection.on("close", function() { });
  });

  socket.installHandlers(server, { prefix: "/socket" });

  return socket;
};
