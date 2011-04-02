global.Backbone = require 'backbone'
todoFixtures    = require "#{__dirname}/fixtures/todos"
# TODO: make model testing work.
#{Todos}         = require "#{__dirname}/../main/coffeescript/model"
browser         = require('tobi').createBrowser 3333, 'localhost'

module.exports =
  'Nodeunit env is set up correctly.': (test) ->
  	test.expect 1
  	test.ok true
  	test.done()
  	return

  'Request `/` returns expected response.': (test) ->
    browser.get '/', (res, $) ->
      res.should.have.status 200
      $('#todoapp .title').should.include.text 'Todos'
      test.done()
      return
    return
