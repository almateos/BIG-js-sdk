define ['base', 'hbs!templates/player-list'], (base, usersList) ->
    
    class Player extends base.Model
        urlRoot: '/players'
    
    class PlayersCollectionView extends base.View
        template: playerList
        collection: {on: () -> }
        initialize: (collection)->
            this.collection.on 'all', this.render
 
    class PlayersCollection extends base.Collection
        model: Player
        urlRoot: '/players'
        
    return {
        Model: Player
        Collection: PlayersCollection
        CollectionView: PlayersCollectionView
    }
