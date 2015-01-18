var path = require("path");

var sockjs = require("sockjs");

var sockjsOpts = { sockjs_url: "http://cdn.sockjs.org/sockjs-0.3.4.min.js" }
var socket = sockjs.createServer(sockjsOpts);

module.exports.listen = function(server) {
  server.addListener("upgrade", function(_, res){
    res.end();
  });

  socket.on("connection", function(connection) {
    connection.on("data", function(rawInput) { });
    connection.on("close", function() { });
  });

  socket.installHandlers(server, { prefix: "/socket" });

  return socket;
};
