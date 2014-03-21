# For more information see: http://emberjs.com/guides/routing/

Auth.LoadingRoute = Ember.Route.extend
  beforeModel:()->
    Ember.$('.navbar-header').hide()
    return
  ,
  afterModel:()->
    Ember.$('.navbar-header').show()
    return
