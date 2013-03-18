define ['jquery','underscore', 'json2', 'config'], ($, _, JSON, config) ->

    "use strict"
    
    methods = ['GET','POST', 'PUT', 'DELETE']
    user = null
    initialized = false
    socket = null
    
    authKeys =
        api_key: null
        player_id: null
        player_token: null
    
    # fake browser console if shitty browser
    console = window.console || {
        log: ()-> {}
        info: ()-> {}
        warn: ()-> {}
        error: ()-> {}
        }
    
    ###### PRIVATE METHODS #######
    # socket and socket events initialization
    initializeSocket = _.once (callback)->
        # socket = io.connect( config.socket.host || null, config.socket.settings || { 'sync disconnect on unload': true})
        # exemple event
        # socket.on 'defy', (message)-> console.log('defy', message)
        callback()
        
    
    ###### PUBLIC METHODS #######    
    ## SDK initialization
    init = _.once (keys, callback) ->
        initialized = true
        authKeys = _.extend(authKeys, keys)
        api 'get', '/players/' + authKeys.player_id, {}, (err, response)->
            if err
                initialized = false
                console.log err
                callback err, null
            else
                initializeSocket ()->
                    callback(null, response)
            
    ## Generic rest api wrapper
    api = (method, endpoint, params, callback) ->
        return console.error('BIG.api called before BIG.init') unless initialized
        # check method validity
        requestType = method.trim().toUpperCase()
        callback({code: 405, error: "Bad method type"}, null) unless methods.indexOf(requestType) > -1
        
        # automatically add authentication params to url
        url = config.api.host + (if endpoint.match(/\?/) then endpoint + '&' else endpoint + '?') + $.param(authKeys)
        

        # jquery ajax settings
        requestSettings  =
            url: url
            type: requestType
            data: params
            dataType: 'json'
            statusCode:
                401: () -> callback({code:401, error: 'Authentication error'}, null)
                403: () -> callback({code:403, error: 'Authorization error'}, null)
            global: false
            success: (data) -> callback(null, data)
        
        # TODO: var below was undefined
        jqueryParams = {}
        # if POST/PUT, put data in request payload instead of params
        if requestType == 'POST' || requestType == 'PUT'
            jqueryParams = _.extend jqueryParams,
                data: JSON.stringify(params)
                processData: false
                contentType: 'application/json'
        
        # aaand the request. finally
        $.ajax(requestSettings)
    
    
    map = {
        users:       ['user',  'CollectionView', {}]
        'user-list': ['user',  'CollectionView', {}]
        lobby:       ['lobby', 'View']
        bank:        ['bank',  'View']
    }
    ui = (name, element, params) ->

        test = map[name]
        require [test[0]], (obj) ->
            view = new obj[test[1]] _.extend({el: element}, test[2])
            view.render(params)
        
    #ui = (params, callback) ->
    ###defy = (defy, callback) ->
        return console.error('BIG.defy called before BIG.init') unless initialized
        socket.emit(defy.from, 'defy', defy.to)
    
        socket.on 'defyAnswer', () ->
            # create defy
            api('post', 'defy', defyJson, (err, defy) ->
                if(!err)
                    if(defy)
                        # get tournament
                        api 'get', 'tournament', {defy_id: defy.id}, (err, tournament) ->
                            callback(tournament)
                    else
                        socket.emit(defy.from, 'ui', 'fail to create defy')
                        socket.emit(defy.to, 'ui', 'fail to create defy')
    ###
    
    #### expose public methods
    return {
        init: init
        api: api
        ui: ui
    }
