global.Backbone = require 'backbone'
global.Store    = (namespace) -> return
{todos}         = require "#{__dirname}/fixtures/todos"
{Todos}         = require "#{__dirname}/../main/coffeescript/model"
browser         = require('tobi').createBrowser 3333, 'localhost'

module.exports =
  'Nodeunit env is set up correctly.': (test) ->
  	test.expect 1
  	test.ok true
  	test.done()
  	return

  'Todo models hold data as expected.': (test) ->
    test.expect 4
    Todos.add todos
    models = Todos.models
    model = models[1]
    test.same 'Test.', model.get('content')
    test.ok not model.get('done')
    model = models[0]
    test.same 'Fix.', model.get('content')
    test.ok model.get('done')
    test.done()
    return

  'Request `/` returns expected response.': (test) ->
    browser.get '/', (res, $) ->
      res.should.have.status 200
      $('#todoapp .title').should.include.text 'Todos'
      $('#new-todo').should.have.attr 'placeholder', 'What needs to be done?'
      test.done()
      return
    return
