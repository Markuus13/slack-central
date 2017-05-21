//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();
/* Code under test. Will be refactored soon. */
App.quotes = App.cable.subscriptions.create('QuotesChannel', {
  received: function(data) {
    $("#quote-text").animate({ opacity: 0 }, 400, function() {
      $("#quote-text").empty();
    });

    $("#quote-author").animate({ opacity: 0 }, 400, function() {
      $("#quote-author").empty();
    });

    $("#quote-text").append(this.renderText(data));
    $("#quote-author").append(this.renderAuthor(data));
  },
  renderText: function(data) {
    return data.text;
  },
  renderAuthor: function(data) {
    return data.author;
  }
});
