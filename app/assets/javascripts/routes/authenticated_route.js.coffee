Auth.AuthenticatedRoute = Ember.Route.extend
  beforeModel: (transition)->
    if Ember.isEmpty(@controllerFor('sessions').get('token'))
      @redirectToLogin(transition)
  ,
  # Redirect to the login page and store the current transition so we can
  # run it again after login
  redirectToLogin: (transition)->
    @controllerFor('sessions').set('attemptedTransition', transition)
    @transitionTo('sessions')
  ,
  actions:
    error: (reason, transition)->
      if (reason.status is 401)
        @redirectToLogin(transition)
      else
        console.log('unknown problem')
      return
