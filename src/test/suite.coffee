http            = require 'http'
global.Backbone = require 'backbone'
todoFixtures    = require "#{__dirname}/fixtures/todos"
# TODO: make model testing work.
#{Todos}         = require "#{__dirname}/../main/coffeescript/model"

module.exports =
  'Nodeunit env is set up correctly.': (test) ->
  	test.expect 1
  	test.ok true
  	test.done()
  	return

  'Request `/` returns expected response.': (test) ->
    test.expect 4
    req = http.get(host: 'localhost', port: 3333, path: '/')
    req.on 'response', (res) ->
      test.same 200, res.statusCode
      res.on 'data', (data) ->
        markup = data.toString()
        test.ok markup
        test.ok /<html/.test(markup)
        test.ok /id="todoapp"/.test(markup)
        test.done()
        return
      return
    return
