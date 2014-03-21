Auth.ApplicationAdapter = DS.RESTAdapter.extend()

Auth.ApplicationAdapter.reopen
  pathForType: (type)->
    decamelized = Ember.String.decamelize(type)
    Ember.String.pluralize(decamelized)

Auth.ApiKeyAdapter = DS.LSAdapter.extend
  namespace: 'emberauth-keys'
