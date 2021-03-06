require.config
    baseUrl: 'build'
    paths:
        underscore: '../vendor/underscore.amd'
        jquery:     '../vendor/jquery-1.9.1.amd'
        backbone:   '../vendor/backbone.amd'
        handlebars: '../vendor/handlebars'
        hbs:        '../vendor/hbs'
        json2:      '../vendor/json2'
        i18nprecompile: '../vendor/i18nprecompile'
        templates:  '../templates'
    shim:
        handlebars:
            exports: 'Handlebars'
        json2:
            exports: 'JSON'
    hbs:
        templateExtension: "hbs"
        disableI18n: true
        disableHelpers: true
        compileOptions: {}

# player not included
require ['BIG', 'bank', 'base', 'config', 'lobby', 'main']
###
((factory) ->
    if(typeof define == 'function' && define.amd)
        #AMD. Register BIG api as anonymous module.
        define factory
    else
        #else register BIG in global window
        window.BIG = factory
)( () ->
    BIG = require ['BIG'], (BIG) ->
        # stuff
) 
###
