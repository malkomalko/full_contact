var request = superagent

$(function(){
  "use strict"

  var user = new FullContactUserViewModel()
  ko.applyBindings(user)
})

var FullContactUserViewModel = function(){
  var self = this

  self.email = ko.observable("")
  self.fullName = ko.observable()
}

FullContactUserViewModel.prototype = {
  emailLookup: function(email, callback){
    var apiBase = "https://api.fullcontact.com/v2/"
      , url = apiBase + "person.json?apiKey=8086e1072816dd03&email="

    $.ajax(url + escape(email), {
      async: true,
      type: "GET",
      success: function(result){
        callback(null, result)
      },
      error: function(obj, status, error){
        callback({ message: "there was an error with your request" })
      },
      dataType: "jsonp"
    })
  },
  fetchContact: function(el){
    var self = this

    this.emailLookup(this.email(), function(err, res){

    })
  }
}
