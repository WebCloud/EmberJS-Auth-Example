Auth.ApplicationRoute = Ember.Route.extend
  actions:
    logout: ()->
      @controllerFor('sessions').reset()
      @transitionTo('sessions')
      return
