(function() {
  var Todo, TodoList;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  Todo = (function() {
    function Todo() {
      Todo.__super__.constructor.apply(this, arguments);
    }
    __extends(Todo, Backbone.Model);
    Todo.prototype.defaults = {
      content: 'empty todo...',
      done: false
    };
    Todo.prototype.initialize = function() {
      if (!this.get('content')) {
        this.set({
          content: this.defaults.content
        });
      }
      return;
    };
    Todo.prototype.toggle = function() {
      this.save({
        done: !this.get('done')
      });
      return;
    };
    Todo.prototype.clear = function() {
      this.destroy();
      this.view.remove();
      return;
    };
    return Todo;
  })();
  TodoList = (function() {
    function TodoList() {
      TodoList.__super__.constructor.apply(this, arguments);
    }
    __extends(TodoList, Backbone.Collection);
    TodoList.prototype.model = Todo;
    TodoList.prototype.localStorage = new Store('todos');
    TodoList.prototype.done = function() {
      return this.filter(function(todo) {
        return todo.get('done');
      });
    };
    TodoList.prototype.remaining = function() {
      return this.without.apply(this, this.done());
    };
    TodoList.prototype.nextOrder = function() {
      if (!this.length) {
        return 1;
      } else {
        return this.last().get('order') + 1;
      }
    };
    TodoList.prototype.comparator = function(todo) {
      return todo.get('order');
    };
    return TodoList;
  })();
  exports.todos = new TodoList;
}).call(this);
