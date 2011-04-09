# Todo Model
# ----------

# Our basic **Todo** model has `content`, `order`, and `done` attributes.
class Todo extends Backbone.Model

  # Default attributes for the todo.
  defaults:
    content: 'empty todo...'
    done: false

  # Ensure that each todo created has `content`.
  initialize: ->
    if not @.get('content')
      @.set content: @defaults.content
    return

  # Toggle the `done` state of this todo item.
  toggle: ->
    @.save done: not @.get('done')
    return

  # Remove this Todo from *storage* and delete its view.
  clear: ->
    @.destroy()
    @view.remove()
    return


# Todo Collection
# ---------------

# The collection of todos is backed by a remote BlueEyes/MongoDB server.
class TodoList extends Backbone.Collection

  # Reference to this collection's model.
  model: Todo

  # Remote BlueEyes server location.
  url: 'http://localhost:8888/todos'

  # Filter down the list of all todo items that are finished.
  done: ->
    @.filter (todo) -> todo.get('done')

  # Filter down the list to only todo items that are still not finished.
  remaining: ->
    @.without.apply @, @.done()

  # We keep the todos in sequential order, despite being saved by unordered
  # GUID in the database. This generates the next order number for new items.
  nextOrder: ->
    if not @length then 1 else @.last().get('order') + 1

  # Todos are sorted by their original insertion order.
  comparator: (todo) ->
    todo.get 'order'


# Create our exported **Todos** collection.
exports.Todos = new TodoList
