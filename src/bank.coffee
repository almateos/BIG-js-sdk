define ['base', 'hbs!templates/bank', 'BIG'], (base, template, BIG) ->
    class BankView extends base.View
        template: template
        events:
          'click button': 'demo'
        demo: (e)->
          that = this
          BIG.api 'GET', '/bank/' + this.data.playerId, { amount: 1000}, (err, response) ->
            console.log err, response
            if(!err)
              that.data.amount += 1000
              document.getElementById('amount').innerHTML = that.data.amount
          
            
    return {
        View: BankView
    }
