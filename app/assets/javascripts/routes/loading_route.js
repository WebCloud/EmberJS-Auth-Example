// For more information see: http://emberjs.com/guides/routing/
Auth.LoadingRoute = Ember.Route.extend({
  beforeModel: function() {
    Ember.$('.navbar-header').hide();
  },
  afterModel: function() {
    Ember.$('.navbar-header').show();
  }
});
