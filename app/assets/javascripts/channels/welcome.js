//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();
/* This code is under test. If it work fine, it will be refactored. */
App.quotes = App.cable.subscriptions.create('QuotesChannel', {
  received: function(data) {
    $("#quote-text").animate({ opacity: 0 }, 400, function() {
      $(this).empty();
    });

    $("#quote-author").animate({ opacity: 0 }, 400, function() {
      $(this).empty();
    });

    $("#quote-text").animate({ opacity: 1 }, 500, function() {
      $(this).append(this.renderText(data));
    });

    $("#quote-author").animate({ opacity: 1 }, 500, function() {
      $(this).append(this.renderAuthor(data));
    });

  },
  renderText: function(data) {
    return data.text;
  },
  renderAuthor: function(data) {
    return data.author;
  }
});
