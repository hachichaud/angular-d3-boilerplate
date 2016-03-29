gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
plumber = require 'gulp-plumber'
gulpfilter = require 'gulp-filter'
replace = require 'gulp-replace'
sourcemaps = require 'gulp-sourcemaps'
wiredep = require('wiredep').stream

parameters = require '../parameters.coffee'

gulp.task 'app', ->
  coffeeFilter = gulpfilter ['**/*.coffee'], restore: true
  gulp.src [
    "#{parameters.paths.src.main}/main.coffee"
    "#{parameters.paths.src.main}/**/module.@(js|coffee)"
    "#{parameters.paths.src.main}/**/*.@(js|coffee)"
  ]
  .pipe plumber()
  .pipe parameters.angular.module.replacer replace
  .pipe sourcemaps.init()
  .pipe coffeeFilter
  .pipe coffee
    bare: true
  .pipe coffeeFilter.restore
  .pipe concat parameters.files.app
  .pipe sourcemaps.write()
  .pipe gulp.dest parameters.paths.www.scripts
