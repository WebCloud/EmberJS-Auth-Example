# For more information see: http://emberjs.com/guides/routing/

Auth.UsersSignupRoute = Ember.Route.extend
  model: ()->
    # define the model for the UsersSignupController as a new record from the User model
    @store.createRecord('user')
  ,
  afterModel: ()->
    # instantiating a jQuery/Twitter Bootstrap datepicker component
    Ember.$(()->
      Ember.$('.input-group.date').datepicker
        startView: 2,
        autoclose: true
      return
    )
    return
