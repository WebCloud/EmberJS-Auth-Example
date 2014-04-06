// For more information see: http://emberjs.com/guides/routing/

Auth.UsersSignupRoute = Ember.Route.extend({
  model: function() {
    // define the model for the UsersSignupController as a new record from the User model
    return this.store.createRecord('user');
  },
  afterModel: function() {
    // instantiating a jQuery/Twitter Bootstrap datepicker component
    Ember.$(function() {
      Ember.$('.input-group.date').datepicker({
        startView: 2,
        autoclose: true
      });
    });
  }
});
