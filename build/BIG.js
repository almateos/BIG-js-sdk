// Generated by CoffeeScript 1.6.1

define(['jquery', 'underscore', 'json2', 'config'], function($, _, JSON, config) {
  "use strict";
  var api, authKeys, console, init, initializeSocket, initialized, map, methods, socket, ui, user;
  methods = ['GET', 'POST', 'PUT', 'DELETE'];
  user = null;
  initialized = false;
  socket = null;
  authKeys = {
    api_key: null,
    player_id: null,
    player_token: null
  };
  console = window.console || {
    log: function() {
      return {};
    },
    info: function() {
      return {};
    },
    warn: function() {
      return {};
    },
    error: function() {
      return {};
    }
  };
  initializeSocket = _.once(function(callback) {
    return callback();
  });
  init = _.once(function(keys, callback) {
    initialized = true;
    authKeys = _.extend(authKeys, keys);
    return api('get', config.api.host + '/players/' + authKeys.player_id, {}, function(err, response) {
      if (err) {
        initialized = false;
        console.error(err);
        return callback(err, null);
      } else {
        return initializeSocket(function() {
          return callback(null, response);
        });
      }
    });
  });
  api = function(method, endpoint, params, callback) {
    var jqueryParams, requestSettings, requestType, url;
    if (!initialized) {
      return console.error('BIG.api called before BIG.init');
    }
    requestType = method.trim().toUpperCase();
    if (!(methods.indexOf(requestType) > -1)) {
      callback({
        code: 405,
        error: "Bad method type"
      }, null);
    }
    url = (endpoint.match(/\?/) ? endpoint + '&' : endpoint + '?') + $.param(authKeys);
    requestSettings = {
      url: url,
      type: requestType,
      data: params,
      dataType: 'json',
      statusCode: {
        401: function() {
          return callback({
            code: 401,
            error: 'Authentication error'
          }, null);
        },
        403: function() {
          return callback({
            code: 403,
            error: 'Authorization error'
          }, null);
        }
      },
      global: false,
      success: function(data) {
        return callback(null, data);
      }
    };
    if (requestType === 'POST' || requestType === 'PUT') {
      jqueryParams = _.extend(jqueryParams, {
        data: JSON.stringify(params),
        processData: false,
        contentType: 'application/json'
      });
    }
    return $.ajax(requestSettings);
  };
  map = {
    users: ['user', 'CollectionView', {}],
    'user-list': ['user', 'CollectionView', {}],
    lobby: ['lobby', 'View'],
    bank: ['bank', 'View']
  };
  ui = function(name, element, params) {
    var test;
    test = map[name];
    return require([test[0]], function(obj) {
      var view;
      view = new obj[test[1]](_.extend({
        el: element
      }, test[2]));
      return view.render();
    });
  };
  /*defy = (defy, callback) ->
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
  */

  return {
    init: init,
    api: api,
    ui: ui
  };
});
