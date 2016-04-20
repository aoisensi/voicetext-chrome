gulp = require 'gulp'
del = require 'del'
$ = do require 'gulp-load-plugins'

gulp.task 'default', ['manifest', 'script', 'html']

gulp.task 'watch', ['default'], ->
  gulp.watch './src/manifest.yaml', ['manifest']
  gulp.watch './src/script/*.coffee', ['script']
  gulp.watch './src/*.html', ['html']

gulp.task 'manifest', ->
  gulp.src './src/manifest.yaml'
    .pipe do $.yaml
    .pipe gulp.dest './dist'

gulp.task 'script', ->
  gulp.src './src/script/*.coffee'
    .pipe do $.coffee
    .pipe gulp.dest './dist/script/'
    
gulp.task 'html', ->
  gulp.src './src/*.html'
    .pipe gulp.dest './dist/'
    
gulp.task 'clean', ->
  del 'dist'