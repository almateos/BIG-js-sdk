// Generated by CoffeeScript 1.6.1

define(['jquery', 'underscore', 'json2', 'socket.io', 'config'], function($, _, JSON, io, config) {
  "use strict";
  /* fake browser console if browser has no console
  */

  var api, authKeys, console, init, initializeSocket, initialized, methods, socket, user;
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
  authKeys = {
    apiId: null,
    userId: null,
    userToken: null
  };
  methods = ['GET', 'POST', 'PUT', 'DELETE'];
  user = null;
  initialized = false;
  socket = null;
  initializeSocket = _.once(function(callback) {
    socket = io.connect(config.socket.host || null, config.socket.settings || {
      'sync disconnect on unload': true
    });
    return callback();
  });
  init = _.once(function(keys, callback) {
    authKeys = _.extend(authKeys, keys);
    return api('get', '/users/me', {}, function(err, response) {
      if (err) {
        console.error(err);
        return callback(err, null);
      } else {
        initialized = true;
        return initializeSocket(function() {
          return callback(null, user);
        });
      }
    });
  });
  api = function(method, endpoint, params, callback) {
    var jqueryParams, requestSettings, requestType, url, _ref;
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
    url = ((_ref = endpoint.match(/\?/)) != null ? _ref : endpoint + {
      '&': endpoint + '?'
    }) + $.params(authKeys);
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
    defy: defy
  };
});
