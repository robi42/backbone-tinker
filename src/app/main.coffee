# An example Backbone application contributed by
# [Jérôme Gravel-Niquet](http://jgn.me/). This demo uses a simple
# LocalStorage adapter to persist Backbone models within your browser.

# Load the application once the DOM is ready, using `jQuery.ready`:
$ ->

  # Finally, we kick things off by creating the **app**.
  window.app = new (require('view').AppView)
  return
