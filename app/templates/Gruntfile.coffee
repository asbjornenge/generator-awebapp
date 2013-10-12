#### GLOBALS ####

'use strict'

module.exports = (grunt) ->

    #### LOAD / CONFIG ####

    require('time-grunt')(grunt)
    require('load-grunt-tasks')(grunt)

    config =
        app  : 'app'
        dist : 'dist'

    #### INITCONFIG ####

    @initConfig
        yeoman : config,
        pkg    : @file.readJSON 'package.json'

        ## STYLUS
        #

        stylus:
            server:
                files:
                    '.tmp/styles/main.css' : ['<%= yeoman.app %>/styles/*.styl']

        ## CONCAT
        #
        # Auto by useminPrepare


        ## CSSMIN
        #

        cssmin:
            options:
                banner : '/* BANNER */'

        ## REQUIREJS
        #

        requirejs:
            app:
                options:
                    baseUrl        : 'app/scripts/'
                    mainConfigFile : 'app/scripts/main.js'
                    name           : 'main'
                    out            : 'dist/main.min.js'
                    optimize       : 'uglify'
                    almond         : true
                    findNestedDependencies: true
                    paths:
                        jquery : '../bower_components/jquery/jquery'

        ## USEMIN PREPARE
        #

        useminPrepare:
            html: '<%= yeoman.app %>/index.html'
            options:
                dest: '<%= yeoman.dist %>'

        ## HTMLREFS
        #

        htmlrefs:
            dist:
                src: '<%= yeoman.app %>/index.html'
                dest : '<%= yeoman.dist %>'

        ## WATCH
        #

        watch:
            styles:
                files: ['<%= yeoman.app %>/styles/{,*/}*.styl']
                tasks: ['stylus:server']
            livereload:
                options:
                    livereload: '<%= connect.options.livereload %>'
                files : [
                    '<%= yeoman.app %>/*.html',
                    '{.tmp,<%= yeoman.app %>}/styles/*.css',
                    '{.tmp,<%= yeoman.app %>}/scripts/**/*.js',
                    '<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}',
                    'tests/{,*/}*.js',
                ]

        ## MOCHA
        #

        mochaTest:
            test:
                options:
                    reporter: 'nyan'
                src: ['test/*.js']

        ## SERVER
        #

        connect:
            options:
                port: 9000
                livereload: 35729
                # change this to '0.0.0.0' to access the server from outside
                hostname: 'localhost'
            livereload:
                options:
                    open: true
                    base: [
                        '.tmp'
                        '<%= yeoman.app %>'
                    ]
            test:
                options:
                    base: [
                        '.tmp'
                        'test'
                        '<%= yeoman.app %>'
                    ]
            dist:
                options:
                    open: true
                    base: '<%= yeoman.dist %>'

        clean:
            dist:
                files: [
                    dot: true,
                    src: [
                        '.tmp',
                        '<%= yeoman.dist %>/*',
                        '!<%= yeoman.dist %>/.git*'
                    ]
                ]
            server: '.tmp'

        ## COPY
        #

        copy:
            dist:
                files: [
                    {
                        src: 'dist/main.min.js'
                        dest: 'dist/<%= pkg.version %>/main.min.js'
                    }
                    {
                        src: 'dist/main.min.css'
                        dest: 'dist/<%= pkg.version %>/main.min.css'
                    }
                    {
                        src: 'dist/index.html'
                        dest: 'dist/<%= pkg.version %>/index.html'
                    }
                ]

    #### TASKS ####

    ## Server
    #

    @registerTask 'server', (target) =>
        @task.run 'clean:server'
        @task.run 'stylus:server'
        @task.run 'connect:livereload'
        @task.run 'watch'

    ## Test
    #

    @registerTask 'test', (target = 'all') =>
        @task.run 'mochaTest'

    ## Build
    #

    @registerTask 'build', (target = 'all') =>
        @task.run 'clean:server'
        @task.run 'stylus:server'
        @task.run 'useminPrepare'
        @task.run 'concat'
        @task.run 'cssmin'
        @task.run 'requirejs'
        @task.run 'htmlrefs:dist'
        @task.run 'copy:dist'

    ## Default
    #

    @registerTask 'default', ['test']
