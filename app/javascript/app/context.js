(function() {
  var Context;

  Context = (function() {
    Context.initialize = function() {
      console.log("[Context]: Context initialize");
      return window.context = new Context;
    };

    function Context() {
      console.log("[Context]: Context app object created");
      this.handleEmptyTasks();
      this.handleFilledTasks();
      this.handleContextTask();
    }

    Context.prototype.handleEmptyTasks = function() {
      return $(document).on('click', '.tasks__next__empty-element', function() {
        var content;
        content = prompt('Напишите содержание задачи.');
        if (content) {
          return $.post('/tasks', {
            content: content
          }, (function(_this) {
            return function(answer) {
              if (answer.success) {
                console.log("[Context]: Created task");
                $(_this).html(content);
                $(_this).data('id', answer.id);
                $(_this).removeClass('tasks__next__empty-element');
                return $(_this).addClass('tasks__next__filled-element');
              } else {
                return alert('Задача не создана, но почему?!');
              }
            };
          })(this));
        }
      });
    };

    Context.prototype.handleFilledTasks = function() {
      return $(document).on('click', '.tasks__next__filled-element', function() {
        var id;
        id = $(this).data('id');
        return $.post('/tasks/' + id + '/incontext', {}, (function(_this) {
          return function(answer) {
            if (answer.success) {
              console.log("[Context]: Task " + id + " was set in context");
              $('.tasks__context__element').html(answer.content);
              $(_this).removeClass('tasks__next__filled-element');
              $(_this).addClass('tasks__next__empty-element');
              return $(_this).html('+');
            } else {
              return alert('Ваш контекст уже установлен.');
            }
          };
        })(this));
      });
    };

    Context.prototype.handleContextTask = function() {};

    return Context;

  })();

  window.Context = Context;

}).call(this);