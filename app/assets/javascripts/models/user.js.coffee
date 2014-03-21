# for more details see: http://emberjs.com/guides/models/defining-models/

Auth.User = DS.Model.extend
  name:     DS.attr('string'),
  email:    DS.attr('string'),
  username: DS.attr('string'),
  password: DS.attr('string'),
  password_confirmation: DS.attr('string'),
  apiKeys: DS.hasMany('apiKey'),
  errors: {}