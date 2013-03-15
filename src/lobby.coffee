define ['base', 'hbs!templates/lobby'], (base, template) ->
    class LobbyView extends base.View
        template: template
        events: 
            'click h1': 'shout'
        shout: ()->
            alert 'STOu'
            
    return {
        View: LobbyView
    }
    
    