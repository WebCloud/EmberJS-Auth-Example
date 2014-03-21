# for more details see: http://emberjs.com/guides/controllers/

Auth.SessionsController = Ember.Controller.extend
  init:()->
    @_super()
    if Ember.$.cookie('access_token')
      Ember.$.ajaxSetup
        headers: { 'Authorization': 'Bearer ' + Ember.$.cookie('access_token') }
    return
  ,
  attemptedTransition: null,
  token:               Ember.$.cookie('access_token'),
  currentUser:         Ember.$.cookie('auth_user'),
  tokenChanged: (()->
    if Ember.isEmpty(@get('token'))
      Ember.$.removeCookie('access_token')
      Ember.$.removeCookie('auth_user')
    else
      Ember.$.cookie('access_token', @get('token'))
      Ember.$.cookie('auth_user', @get('currentUser'))
    return
  ).observes('token'),
  reset:()->
    @setProperties
      username_or_email: null,
      password:          null,
      token:             null,
      currentUser:       null
    Ember.$.ajaxSetup
      headers: { 'Authorization': 'Bearer none' }
    return
  ,
  actions:
    loginUser: ()->
      data           = @getProperties('username_or_email', 'password')
      attemptedTrans = @get('attemptedTransition')

      @setProperties
        username_or_email: null,
        password:          null

      Ember.$.post('/session', data).then((response)=>
        Ember.$.ajaxSetup
          headers: { 'Authorization': 'Bearer ' + response.api_key.access_token }

        key = @get('store').createRecord('apiKey', {accessToken: response.api_key.access_token})

        @store.find('user', response.api_key.user_id).then((user)=>
          @setProperties
            token:       response.api_key.access_token,
            currentUser: user.getProperties('username','name','email')

          key.set('user', user)
          key.save()

          user.get('apiKeys').content.push(key)

          if attemptedTrans
            attemptedTrans.retry()
            @set('attemptedTransition', null)
          else
            @transitionToRoute('secret')

          return
        )

        return
      , (error)->
        if error.status is 401
          alert("wrong user or password, please try again")
        return
      )
