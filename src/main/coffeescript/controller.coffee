{HomeView} = require 'view'


# App Controller
# --------------
class exports.App extends Backbone.Controller
  initialize: ->
    super
    @views = {}
    return

  routes:
    ''     : 'index'
    '/home': 'index'

  index: ->
    @views.home = new HomeView
    return
