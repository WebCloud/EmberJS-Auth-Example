# for more details see: http://emberjs.com/guides/models/defining-models/

Auth.ApiKey = DS.Model.extend
  accessToken:  DS.attr('string'),
  user:         DS.belongsTo('user', {async:true})
