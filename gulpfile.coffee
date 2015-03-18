gulp = require 'gulp'
coffee = require 'gulp-coffee'
cson = require 'gulp-cson'

paths =
  coffee: 'src/*.coffee'
  cson: 'src/*.cson'
  dest: 'build'

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe coffee()
    .pipe gulp.dest paths.dest

gulp.task 'cson', ->
  gulp.src paths.cson
    .pipe cson()
    .pipe gulp.dest paths.dest

gulp.task 'default', ['coffee', 'cson']
gulp.task 'watch', ['default'], ->
  gulp.watch paths.jade, ['jade']
  gulp.watch paths.cson, ['cson']
