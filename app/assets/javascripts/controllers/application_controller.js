// for more details see: http://emberjs.com/guides/controllers/

Auth.ApplicationController = Ember.Controller.extend({
  // requires the sessions controller
  needs:           'sessions'],

  // creates a computed property called currentUser that will be
  // binded on the curretUser of the sessions controller and will return its value
  currentUser:     (function() {
    return this.get('controllers.sessions.currentUser');
  }).property('controllers.sessions.currentUser'),

  // creates a computed property called isAuthenticated that will be
  // binded on the curretUser of the sessions controller and will verify if the object is empty
  isAuthenticated: (function() {
    return !Ember.isEmpty(this.get('controllers.sessions.currentUser'));
  }).property('controllers.sessions.currentUser')
});
