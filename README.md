BIG-js-sdk
==========

Raw api usage (Transparent, 2 days integration):
``client1 => editor website => almapi => editor website => client2``

TODO (as editor):
- view (micro kit with empty function)
- Wrap communication (server side):
    - client connection 
       ``BIG.init({apiKey:"", apiSecret: ""}, callback(user||false))`` 
        => POST {apiKey:"", apiSecret: ""} on http://almapi.be/game/auth
    - defi creation
        ``BIG.defy({from: player_id, to: player_id, lobby: lobby_id}, callback(err, tournament|| false))``
        => ``BIG.api('post', 'defy', defyJson, callback(err, result))`` 
        => POST params http://almapi.be/game/defies/
    - accept defi
    -  ``BIG.api('put', 'defies', updatedDefyJson, callback(err, result))``
    - report result
        ``BIG.report(tournament, callback({credits_cmd})
    - defi invitation (client2)
    


Integration kit (fast integration):
``client1 => AlmaNodeJsication => almapi => AlmaNodeJsication => client2``

BIG.render(elementSelector, {collection : connectedList, })

BIG.ui({type:'lobby', element: '#lobby'}, callback) 

