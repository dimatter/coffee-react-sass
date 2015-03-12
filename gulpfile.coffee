gulp =            require 'gulp'
coffee =          require 'gulp-coffee'
concat =          require 'gulp-concat'
gutil =           require 'gulp-util'
sass =            require 'gulp-sass'
filter =          require 'gulp-filter'
del =             require 'del'
browserify =      require 'browserify'
watchify =        require 'watchify'
source =          require 'vinyl-source-stream'
bower =           require 'main-bower-files'
nodemon =         require 'gulp-nodemon'

paths =
  public:         './public'
  scripts:        './client/coffee'
  vendor:         './vendor'
  html:           './client/*.html'
  assets:         './client/assets/**'
  images:         './client/assets/images/**'
  styles:         './client/styles/**'

files =
  app:
    js:           'application.js'
  vendor:
    js:           'vendor.js'

args = watchify.args
args.extensions = ['.coffee', '.cjsx']

bundler = watchify(browserify paths.scripts + '/application.coffee', args)
bundler.transform 'coffee-reactify'

bundle = ->
  bundler.bundle()
    .on 'error', gutil.log.bind(gutil, 'Browserify Error')
    .pipe source(files.app.js)
    .pipe gulp.dest(paths.public)

bundler.on 'update', bundle

gulp.task 'scripts', bundle

gulp.task 'vendor', ->

  gulp.src bower().concat("vendor/*.js")
    .pipe filter("**/*.js")
    .pipe concat(files.vendor.js)
    .pipe gulp.dest(paths.public)

  gulp.src bower().concat("vendor/*.css")
    .pipe filter("**.*.css")
    .pipe concat("vendor.css")
    .pipe gulp.dest(paths.public)

gulp.task 'sass', ->
  gulp.src "#{paths.styles}/application.scss"
    .pipe sass(errLogToConsole: true, sourceComments: 'normal', loadPath: [__dirname + '/bower_components/fontawesome/scss/'])
    .pipe gulp.dest(paths.public)

gulp.task 'assets', ->
  gulp.src paths.images
    .pipe gulp.dest(paths.public + "/images")

gulp.task 'html', ->
 gulp.src paths.html
    .pipe gulp.dest(paths.public)

gulp.task 'watch', ->
  gulp.watch paths.scripts, ['scripts']
  gulp.watch paths.vendor, ['vendor']
  gulp.watch paths.assets, ['assets']
  gulp.watch paths.html, ['html']
  gulp.watch paths.styles, ['sass']

gulp.task 'server', ->
  nodemon( script: './server/main.coffee')
    .on 'restart', -> console.log "Server restarted"

gulp.task 'icons', ->
  gulp.src  'bower_components/fontawesome/fonts/**.*'
    .pipe(gulp.dest('./public/fonts')); 

gulp.task 'default', [
  'server'
  'watch'
  'assets'
  'html'
  'scripts'
  'vendor'
  'sass'
  'icons'
]
