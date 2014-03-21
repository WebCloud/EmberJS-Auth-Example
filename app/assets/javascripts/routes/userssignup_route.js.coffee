Auth.UsersSignupRoute = Ember.Route.extend
  model: ()->
    @store.createRecord('user')
  ,
  afterModel: ()->
    Ember.$(()->
      Ember.$('.input-group.date').datepicker
        startView: 2,
        autoclose: true
      return
    )
    return
