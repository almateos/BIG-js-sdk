require.config
    paths:
        underscore: '../vendor/underscore.amd'
        jquery:     '../vendor/jquery-1.9.1.amd'
        backbone:   '../vendor/backbone.amd.js'
    
    

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