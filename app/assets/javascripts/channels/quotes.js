App.quotes = App.cable.subscriptions.create('QuotesChannel', {
  received: function(data) {
    $("#all-quotes").append(this.renderMessage(data))
  },
  renderMessage: function(data) {
    return "<p><strong>Author:</strong>" + data.author + "</p>"
         + "<p><strong>Quote:</strong>" + data.text + "</p>";
  }
});
