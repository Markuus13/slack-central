//= require cable
//= require_self
//= require_tree .

this.App = {};

App.cable = ActionCable.createConsumer();
App.quotes = App.cable.subscriptions.create('QuotesChannel', {
  received: function(data) {
    $("#last-quote").empty();
    $("#last-quote").append(this.renderMessage(data))
  },
  renderMessage: function(data) {
    return "<p>" + data.text + "</p>"
         + "<p>by <strong>" + data.author + "</strong></p>"
  }
});
