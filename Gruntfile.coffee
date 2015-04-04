webpack = require 'webpack'

module.exports = (grunt) ->

  pkg = grunt.file.readJSON 'package.json'

  config =
    clean:
      main: ['dist']

    copy:
      main:
        files: [
          expand: true
          cwd: 'src/'
          src: ['**', '!**/*.coffee', '!**/*.less']
          dest: 'dist/'
        ]

    webpack:
      options:
        module:
          loaders: [
            { test: /\.coffee$/, loader: 'coffee-loader' }
            { test: /\.html$/, loader: 'html-loader', query: {minimize: false} }
          ]
        devtool: 'source-map'
      main:
        entry: {
          app: './src/app.coffee'
          client: './src/client.coffee'
        }
        output:
          path: 'dist/<%= relativePath %>/'
          filename: '[name].js'
      dist:
        plugins: [
          new webpack.optimize.UglifyJsPlugin(mangle: false)
        ]
        entry: './src/app.coffee'
        output:
          path: 'build/<%= relativePath %>/'
          filename: 'bundle.js'

    less:
      main:
        files: [
          expand: true
          cwd: 'src/'
          src: ['style/screen.less']
          dest: 'dist/'
          ext: '.css'
        ]

    connect:
      http:
        options:
          hostname: '*'
          port: 443
          base: '.'
          protocol: 'https'
          livereload: true

    watch:
      options:
        livereload:
          port: 35729
          key: grunt.file.read('node_modules/grunt-contrib-connect/tasks/certs/server.key')
          cert: grunt.file.read('node_modules/grunt-contrib-connect/tasks/certs/server.crt')
      webpack:
        files: ['src/**/*.coffee', 'src/**/*.html']
        tasks: ['webpack:main']
      less:
        options:
          livereload: false
        files: ['src/style/**/*.less']
        tasks: ['less']
      css:
        files: ['dist/**/*.css']
      main:
        files: ['src/lib/**/*',
                'index.html']
        tasks: ['copy:main']
      gruntfile:
        files: ['Gruntfile.coffee']

  tasks =
  # Building block tasks
    build: ['clean', 'webpack:main', 'less', 'copy:main']
  # Deploy tasks
    dist: ['clean', 'webpack:dist'] # Dist - minifies files
    test: []
  # Development tasks
    default: ['build', 'connect', 'watch']

  # Project configuration.
  grunt.config.init config
  grunt.loadNpmTasks name for name of pkg.devDependencies when name[0..5] is 'grunt-' and name isnt 'grunt-vtex'
  grunt.registerTask taskName, taskArray for taskName, taskArray of tasks