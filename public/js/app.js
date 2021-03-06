var request = superagent

$(function(){
  "use strict"

  var user = new FullContactUserViewModel()
  ko.applyBindings(user)
})

var FullContactUserViewModel = function(){
  var self = this

  self.email = ko.observable("")
  self.fullName = ko.observable("")
  self.likelihood = ko.observable()
  self.madeRequest = ko.observable(false)
  self.photo = ko.observable()
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
      if (err) return console.log(err.message)
      self.updateUser(res)
    })
  },
  updateUser: function(res){
    $(".contact-screen").css("min-height", 214)

    this.fullName(res.contactInfo.fullName)
    this.madeRequest(true)
    if (!_.isEmpty(res.photos)) this.photo(res.photos[0].url)
    this.likelihood(res.likelihood)
  }
}
