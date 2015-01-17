var exec = require('child_process').exec;

var gulp = require("gulp");
var server = require("gulp-express");

gulp.task("default", ["server"]);

gulp.task("server", function () {
  server.run({
    file: "server.js"
  });

  gulp.watch("Pong.elm", function(_) {
    exec("elm-make Pong.elm --output public/pong.js");
  });
});
