# For more information see: http://emberjs.com/guides/routing/

Auth.SessionsRoute = Ember.Route.extend
  # setup the SessionsController by resetting it to avoid data from a past authentication
  setupController: (controller, context)->
    controller.reset()
    return
  ,
  beforeModel: (transition)->
    # before proceeding any further, verify if the token property is not empty
    # if it is, transition to the secret route
    if !Ember.isEmpty(@controllerFor('sessions').get('token'))
      @transitionTo('secret')
    return
