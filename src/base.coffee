define ['backbone','underscore','config'], (backbone, _, config) ->

    class View extends backbone.View
        data: {}
        render: (data)->
            this.data = data
            this.$el.html this.template(data)
        
    class Model extends backbone.Model
        url: () ->
            config.api.host + super
    
    class Collection extends backbone.Collection
        url: () ->
            base = _.result(this, 'urlRoot')
            config.api.host + base
            
    return {
        Model: Model
        View: View
        Collection: Collection
    }
    
