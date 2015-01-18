var exec = require('child_process').exec;

var gulp = require("gulp");
var server = require("gulp-express");

gulp.task("default", ["server"]);

gulp.task("server", function () {
  server.run({
    file: "lib/server.js"
  });

  gulp.watch("**/*.elm", function(_) {
    exec("elm-make Pong/Client.elm --output public/pong.js", function(err, stdout, stderr) {
      if (err) {
        console.log(err);
      }

      if (stdout) {
        console.log(stdout.toString());
      }

      if (stderr) {
        console.log(stderr.toString());
      }
    });
  });
});
