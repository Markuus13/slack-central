//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();

App.quotes = App.cable.subscriptions.create('QuotesChannel', {
  received: function(data) {
    $("#quote-text").empty();
    $("#quote-author").empty();
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
