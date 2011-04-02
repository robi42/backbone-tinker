{AppView} = require 'view'


# App Controller
# --------------

# Basically, just lays out `/#/home` route.
class exports.App extends Backbone.Controller
  initialize: ->
    super
    @views = {}
    return

  routes:
    ''     : 'index'
    '/home': 'index'

  index: ->
    @views.home = new AppView
    return
