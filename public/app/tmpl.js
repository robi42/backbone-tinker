(function(){exports.tmpl = {};exports.tmpl.item = module.exports = function(__obj) {
  var _safe = function(value) {
    if (typeof value === 'undefined' && value == null)
      value = '';
    var result = new String(value);
    result.ecoSafe = true;
    return result;
  };
  return (function() {
    var __out = [], __self = this, _print = function(value) {
      if (typeof value !== 'undefined' && value != null)
        __out.push(value.ecoSafe ? value : __self.escape(value));
    }, _capture = function(callback) {
      var out = __out, result;
      __out = [];
      callback.call(this);
      result = __out.join('');
      __out = out;
      return _safe(result);
    };
    (function() {
      _print(_safe('<div class="todo '));
      _print(this.done ? 'done' : '');
      _print(_safe('">\n  <div class="display">\n    <input class="check" type="checkbox" '));
      _print(this.done ? 'checked="checked"' : '');
      _print(_safe(' />\n    <div class="todo-content"></div>\n    <span class="todo-destroy"></span>\n  </div>\n  <div class="edit">\n    <input class="todo-input" type="text" value="" />\n  </div>\n</div>\n'));
    }).call(this);
    
    return __out.join('');
  }).call((function() {
    var obj = {
      escape: function(value) {
        return ('' + value)
          .replace(/&/g, '&amp;')
          .replace(/</g, '&lt;')
          .replace(/>/g, '&gt;')
          .replace(/"/g, '&quot;');
      },
      safe: _safe
    }, key;
    for (key in __obj) obj[key] = __obj[key];
    return obj;
  })());
};;exports.tmpl.stats = module.exports = function(__obj) {
  var _safe = function(value) {
    if (typeof value === 'undefined' && value == null)
      value = '';
    var result = new String(value);
    result.ecoSafe = true;
    return result;
  };
  return (function() {
    var __out = [], __self = this, _print = function(value) {
      if (typeof value !== 'undefined' && value != null)
        __out.push(value.ecoSafe ? value : __self.escape(value));
    }, _capture = function(callback) {
      var out = __out, result;
      __out = [];
      callback.call(this);
      result = __out.join('');
      __out = out;
      return _safe(result);
    };
    (function() {
      if (this.total) {
        _print(_safe('\n  <span class="todo-count">\n    <span class="number">'));
        _print(this.remaining);
        _print(_safe('</span>\n    <span class="word">'));
        _print(this.remaining === 1 ? 'item' : 'items');
        _print(_safe('</span> left.\n  </span>\n'));
      }
      _print(_safe('\n'));
      if (this.done) {
        _print(_safe('\n  <span class="todo-clear">\n    <a href="#">\n      Clear <span class="number-done">'));
        _print(this.done);
        _print(_safe('</span>\n      completed <span class="word-done">'));
        _print(this.done === 1 ? 'item' : 'items');
        _print(_safe('</span>\n    </a>\n  </span>\n'));
      }
      _print(_safe('\n'));
    }).call(this);
    
    return __out.join('');
  }).call((function() {
    var obj = {
      escape: function(value) {
        return ('' + value)
          .replace(/&/g, '&amp;')
          .replace(/</g, '&lt;')
          .replace(/>/g, '&gt;')
          .replace(/"/g, '&quot;');
      },
      safe: _safe
    }, key;
    for (key in __obj) obj[key] = __obj[key];
    return obj;
  })());
};;})();