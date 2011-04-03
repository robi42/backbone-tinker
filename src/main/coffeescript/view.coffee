item_tmpl  = require 'item_tmpl'
stats_tmpl = require 'stats_tmpl'
{Todos}    = require 'model'


# Todo Item View
# --------------

# The DOM element for a todo item...
class TodoView extends Backbone.View

  #... is a list tag.
  tagName: 'li'

  # The DOM events specific to an item.
  events:
    'click .check'             : 'toggleDone'
    'dblclick div.todo-content': 'edit'
    'click span.todo-destroy'  : 'clear'
    'keypress .todo-input'     : 'updateOnEnter'

  # The TodoView listens for changes to its model, re-rendering. Since there's
  # a one-to-one correspondence between a **Todo** and a **TodoView** in this
  # app, we set a direct reference on the model for convenience.
  initialize: ->
    _.bindAll @, 'render', 'close'
    @model.bind 'change', @.render

    @model.view = @
    return

  # Re-render the contents of the todo item.
  render: ->
    $(@el).html item_tmpl(@model.toJSON())
    @.setContent()
    @

  # To avoid XSS (not that it would be harmful in this particular app),
  # we use `jQuery.text` to set the contents of the todo item.
  setContent: ->
    content = @model.get('content')

    @.$('.todo-content').text content

    @input = @.$('.todo-input')

    @input.bind 'blur', @.close
    @input.val content
    return

  # Toggle the `"done"` state of the model.
  toggleDone: ->
    @model.toggle()
    return

  # Switch this view into `"editing"` mode, displaying the input field.
  edit: ->
    $(@el).addClass 'editing'
    @input.focus()
    return

  # Close the `"editing"` mode, saving changes to the todo.
  close: ->
    @model.save content: @input.val()
    $(@el).removeClass 'editing'
    return

  # If you hit `enter`, we're through editing the item.
  updateOnEnter: (e) ->
    if e.keyCode is 13
      @.close()
    return

  # Remove this view from the DOM.
  remove: ->
    $(@el).remove()
    return

  # Remove the item, destroy the model.
  clear: ->
    @model.clear()
    return


# The Application
# ---------------

# Our overall **AppView** is the top-level piece of UI.
class exports.AppView extends Backbone.View

  # Instead of generating a new element, bind to the existing skeleton of
  # the app already present in the HTML.
  el: $('#todoapp')

  # Delegated events for creating new items, and clearing completed ones.
  events:
    'keypress #new-todo' : 'createOnEnter'
    'keyup #new-todo'    : 'showTooltip'
    'click .todo-clear a': 'clearCompleted'

  # At initialization we bind to the relevant events on the `Todos`
  # collection, when items are added or changed. Kick things off by
  # loading any preexisting todos that might be saved in *localStorage*.
  initialize: ->
    _.bindAll @, 'addOne', 'addAll', 'render'

    @input = @.$('#new-todo')

    Todos.bind 'add',     @.addOne
    Todos.bind 'refresh', @.addAll
    Todos.bind 'all',     @.render

    Todos.fetch()
    return

  # Re-rendering the app just means refreshing the statistics -- the rest
  # of the app doesn't change.
  render: ->
    @.$('#todo-stats').html(stats_tmpl
      total:     Todos.length
      done:      Todos.done().length
      remaining: Todos.remaining().length
    )
    return

  # Add a single todo item to the list by creating a view for it, and
  # appending its element to the `<ul>`.
  addOne: (todo) ->
    view = new TodoView(model: todo)

    @.$('#todo-list').append view.render().el
    return

  # Add all items in the **Todos** collection at once.
  addAll: ->
    Todos.each @.addOne
    return

  # Generate the attributes for a new Todo item.
  newAttributes: ->
    content: @input.val()
    order:   Todos.nextOrder()
    done:    false

  # If you hit return in the main input field, create new **Todo** model,
  # persisting it to *localStorage*.
  createOnEnter: (e) ->
    if e.keyCode isnt 13
      return

    Todos.create @.newAttributes()
    @input.val ''
    return

  # Clear all done todo items, destroying their models.
  clearCompleted: ->
    _.each Todos.done(), (todo) -> todo.clear(); return
    return false

  # Lazily show the tooltip that tells you to press `enter` to save
  # a new todo item, after one second.
  showTooltip: (e) ->
    tooltip = @.$('.ui-tooltip-top')
    val = @input.val()

    tooltip.fadeOut()

    if @tooltipTimeout
      clearTimeout @tooltipTimeout

    if val is '' or val is @input.attr('placeholder')
      return

    show = -> tooltip.show().fadeIn(); return
    @tooltipTimeout = _.delay(show, 1000)
    return
