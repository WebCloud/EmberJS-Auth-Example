Auth.SessionsRoute = Ember.Route.extend
  setupController: (controller, context)->
    controller.reset()
    return
  ,
  beforeModel: (transition)->
    if !Ember.isEmpty(@controllerFor('sessions').get('token'))
      @transitionTo('secret')
    return
