define ['base', 'hbs!templates/bank', 'BIG'], (base, template, BIG) ->
    class BankView extends base.View
        template: template
        events:
          'click button': 'demo'
        demo: (e)->
          that = this
          BIG.api 'GET', '/bank/' + this.data.player_id, { amount: 1000}, (err, response) ->
            console.log err, response
            if(!err)
              that.data.balance += 1000
              #document.getElementById('balance').innerHTML = that.data.balance
              that.render()

              data = BIG.views.lobby.data
              data.user.balance = that.data.balance
              BIG.views.lobby.render(data)

    return {
        View: BankView
    }
