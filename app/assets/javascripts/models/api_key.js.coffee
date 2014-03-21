Auth.ApiKey = DS.Model.extend
  accessToken:  DS.attr('string'),
  user:         DS.belongsTo('user', {async:true})
