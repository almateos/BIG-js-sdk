define ['base', 'hbs!templates/lobby', 'BIG'], (base, template, BIG) ->
    class LobbyView extends base.View
        template: template
        events:
            'click button': 'toggle'
        toggle: (e)->
            lobbyName = e.target.getAttribute('id')
            for key, lobby of this.data.lobbies
              if(lobby.name == lobbyName)
                this.data.lobbies[key].connected = !lobby.connected
                cmd = if lobby.connected then 'join' else 'disconnect'
                BIG.api 'GET', '/lobbies/' + lobby.name, { cmd: cmd}, (err, response) ->
                  console.log(err, response)
                #console.log 2
            
            this.render(this.data)
            
    return {
        View: LobbyView
    }
