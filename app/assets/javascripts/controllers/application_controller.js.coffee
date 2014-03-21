# for more details see: http://emberjs.com/guides/controllers/

Auth.ApplicationController = Ember.Controller.extend
  needs: ['sessions'],
  currentUser:(()->
    @get('controllers.sessions.currentUser')
  ).property('controllers.sessions.currentUser'),
  isAuthenticated: (()->
    !Ember.isEmpty(@get('controllers.sessions.currentUser'))
  ).property('controllers.sessions.currentUser')
