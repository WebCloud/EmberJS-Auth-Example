# For more information see: http://emberjs.com/guides/routing/

# create a base object for any authentication protected route with the required verifications
Auth.AuthenticatedRoute = Ember.Route.extend
  # verify if the token property of the sessions controller is set before continuing with the request
  # if it is not, redirect to the login route (sessions)
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
    # recover from any error that may happen during the transition to this route
    error: (reason, transition)->
      # if the HTTP status is 401 (unauthorised), redirect to the login page
      if (reason.status is 401)
        @redirectToLogin(transition)
      else
        console.log('unknown problem')
      return
