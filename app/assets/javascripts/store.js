
Auth.ApplicationAdapter = DS.RESTAdapter.extend();

// fix the path construction to avoid the cammelCase on the api calls
Auth.ApplicationAdapter.reopen({
  pathForType: function(type) {
    var decamelized = Ember.String.decamelize(type);
    return Ember.String.pluralize(decamelized);
  }
});

// specify that the ApiKey model will comunicate through the LSAdapter and not with the api
Auth.ApiKeyAdapter = DS.LSAdapter.extend({
  namespace: 'emberauth-keys'
});
