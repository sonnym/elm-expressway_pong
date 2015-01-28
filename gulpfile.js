var gulp = require("gulp");

require("elm-expressway/gulpfile")(gulp, "Pong/Client.elm");

gulp.task("default", ["elm-expressway_default"]);
