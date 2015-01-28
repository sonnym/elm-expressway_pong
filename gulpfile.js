var exec = require("child_process").exec;

var gulp = require("gulp");
var server = require("gulp-express");

var elm = require("gulp-elm");

gulp.task("default", ["server", "elm"]);

gulp.task("server", function () {
  server.run({
    file: "lib/server.js"
  });
});

gulp.task("elm", function() {
  return gulp.src("Pong/Client.elm")
    .pipe(elm())
    .pipe(gulp.dest("public"));
});
