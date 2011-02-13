(function() {
  var AppView, TodoView, tmpl, todos;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  tmpl = require('tmpl').tmpl;
  todos = require('model').todos;
  TodoView = (function() {
    function TodoView() {
      TodoView.__super__.constructor.apply(this, arguments);
    }
    __extends(TodoView, Backbone.View);
    TodoView.prototype.tagName = 'li';
    TodoView.prototype.events = {
      'click .check': 'toggleDone',
      'dblclick div.todo-content': 'edit',
      'click span.todo-destroy': 'clear',
      'keypress .todo-input': 'updateOnEnter'
    };
    TodoView.prototype.initialize = function() {
      _.bindAll(this, 'render', 'close');
      this.model.bind('change', this.render);
      this.model.view = this;
    };
    TodoView.prototype.render = function() {
      $(this.el).html(tmpl.item(this.model.toJSON()));
      this.setContent();
      return this;
    };
    TodoView.prototype.setContent = function() {
      var content;
      content = this.model.get('content');
      this.$('.todo-content').text(content);
      this.input = this.$('.todo-input');
      this.input.bind('blur', this.close);
      this.input.val(content);
    };
    TodoView.prototype.toggleDone = function() {
      this.model.toggle();
    };
    TodoView.prototype.edit = function() {
      $(this.el).addClass('editing');
      this.input.focus();
    };
    TodoView.prototype.close = function() {
      this.model.save({
        content: this.input.val()
      });
      $(this.el).removeClass('editing');
    };
    TodoView.prototype.updateOnEnter = function(e) {
      if (e.keyCode === 13) {
        this.close();
      }
    };
    TodoView.prototype.remove = function() {
      $(this.el).remove();
    };
    TodoView.prototype.clear = function() {
      this.model.clear();
    };
    return TodoView;
  })();
  exports.AppView = AppView = (function() {
    function AppView() {
      AppView.__super__.constructor.apply(this, arguments);
    }
    __extends(AppView, Backbone.View);
    AppView.prototype.el = $('#todoapp');
    AppView.prototype.events = {
      'keypress #new-todo': 'createOnEnter',
      'keyup #new-todo': 'showTooltip',
      'click .todo-clear a': 'clearCompleted'
    };
    AppView.prototype.initialize = function() {
      _.bindAll(this, 'addOne', 'addAll', 'render');
      this.input = this.$('#new-todo');
      todos.bind('add', this.addOne);
      todos.bind('refresh', this.addAll);
      todos.bind('all', this.render);
      todos.fetch();
    };
    AppView.prototype.render = function() {
      this.$('#todo-stats').html(tmpl.stats({
        total: todos.length,
        done: todos.done().length,
        remaining: todos.remaining().length
      }));
    };
    AppView.prototype.addOne = function(todo) {
      var view;
      view = new TodoView({
        model: todo
      });
      this.$('#todo-list').append(view.render().el);
    };
    AppView.prototype.addAll = function() {
      todos.each(this.addOne);
    };
    AppView.prototype.newAttributes = function() {
      return {
        content: this.input.val(),
        order: todos.nextOrder(),
        done: false
      };
    };
    AppView.prototype.createOnEnter = function(e) {
      if (e.keyCode !== 13) {
        return;
      }
      todos.create(this.newAttributes());
      this.input.val('');
    };
    AppView.prototype.clearCompleted = function() {
      _.each(todos.done(), function(todo) {
        todo.clear();
      });
      return false;
    };
    AppView.prototype.showTooltip = function(e) {
      var show, tooltip, val;
      tooltip = this.$('.ui-tooltip-top');
      val = this.input.val();
      tooltip.fadeOut();
      if (this.tooltipTimeout) {
        clearTimeout(this.tooltipTimeout);
      }
      if (val === '' || val === this.input.attr('placeholder')) {
        return;
      }
      show = function() {
        tooltip.show().fadeIn();
      };
      this.tooltipTimeout = _.delay(show, 1000);
    };
    return AppView;
  })();
}).call(this);
