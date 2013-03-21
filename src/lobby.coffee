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
              #TODO: post
              BIG.api 'GET', '/lobbies/' + lobby.cost, { cmd: cmd}, (err, response) ->
                console.log(err, response)
              #console.log 2
          
          this.render(this.data)
        
        render: (data) ->
          if data != undefined
            for i in [0...data.lobbies.length]
              data.lobbies[i].disabled = data.user.balance < data.lobbies[i].cost
          console.log data
          super(data)
            
    return {
        View: LobbyView
    }
