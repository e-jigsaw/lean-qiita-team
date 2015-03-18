gulp = require 'gulp'
coffee = require 'gulp-coffee'
cson = require 'gulp-cson'
uglify = require 'gulp-uglify'
gulpif = require 'gulp-if'

paths =
  coffee: 'src/*.coffee'
  cson: 'src/*.cson'
  dest: 'build'

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe coffee()
    .pipe gulpif(process.env.NODE_ENV is 'production', uglify())
    .pipe gulp.dest paths.dest

gulp.task 'cson', ->
  gulp.src paths.cson
    .pipe cson()
    .pipe gulp.dest paths.dest

gulp.task 'default', ['coffee', 'cson']
gulp.task 'watch', ['default'], ->
  gulp.watch paths.coffee, ['coffee']
  gulp.watch paths.cson, ['cson']
