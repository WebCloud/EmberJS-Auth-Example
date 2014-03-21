Auth.UsersSignupController = Ember.Controller.extend
  needs: ['sessions'],
  actions:
    createUser: ()->
      data      = @getProperties(
                    'firstName',
                    'lastName',
                    'email',
                    'username',
                    'password',
                    'password_confirmation'
                  )
      data.name = "#{data.firstName} #{data.lastName}"
      user      = @get('model')

      user.setProperties(data)
      user.save().then((user)=>
        @setProperties
          name:                  null,
          email:                 null,
          username:              null,
          password:              null,
          password_confirmation: null

        sessionsController = @get('controllers.sessions')
        sessionsController.setProperties
          username_or_email: data.username,
          password:          data.password
          
        # remove the record from the localstorage to avoid duplication on the users list
        # as it will come from the api
        user.deleteRecord()
        sessionsController.send('loginUser')
      ,
      (error)->
        if error.status is 422
          errs = JSON.parse(error.responseText)
          user.set('errors', errs.errors)
      )
      return
