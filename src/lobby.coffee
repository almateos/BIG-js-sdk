define ['base', 'hbs!templates/lobby', 'BIG'], (base, template, BIG) ->
    class LobbyView extends base.View
        template: template
        events:
          'click li': 'toggle'
        toggle: (e)->
          lobbyName = e.target.getAttribute('id')
          for key, lobby of this.data.lobbies
            if(lobby.name == lobbyName && lobby.status != null)
              this.data.lobbies[key].status = !lobby.status
              cmd = if lobby.status then 'join' else 'disconnect'
              BIG.api 'PUT', '/lobbies/' + lobby.name, { cmd: cmd }, (err, response) ->
                console.log(err, response)
              #console.log 2
          
          this.render(this.data)
        
        render: (data) ->
          if data != undefined
            for i in [0...data.lobbies.length]
              data.lobbies[i].status = false if data.lobbies[i].status == null
              data.lobbies[i].status = null if data.user.balance < data.lobbies[i].cost
              data.lobbies[i].statusLabel = if data.lobbies[i].status == null then 'disabled' else (if data.lobbies[i].status then 'joined' else 'available')
          super(data)
            
    return {
        View: LobbyView
    }
