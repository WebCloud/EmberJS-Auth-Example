Auth.UsersSignupRoute = Ember.Route.extend
  model: ()->
    @store.createRecord('user')
