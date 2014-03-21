# For more information see: http://emberjs.com/guides/routing/

Auth.ApplicationRoute = Ember.Route.extend
  actions:
    # create a global logout action
    logout: ()->
      # get the sessions controller instance and reset it to then transition to the sessions route
      @controllerFor('sessions').reset()
      @transitionTo('sessions')
      return
