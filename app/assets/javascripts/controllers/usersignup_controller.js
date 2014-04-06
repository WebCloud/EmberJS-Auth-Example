// if there is a authentication error the user is informed of it to try again

Auth.UsersSignupController = Ember.Controller.extend({
  // requires the sessions controller
  needs:   ['sessions'],
  actions: {
    // the user creation action
    createUser: function() {
      var data, user, _this;
      _this = this;

      // get the data from the form
      data = this.getProperties('firstName',
                                'lastName',
                                'email',
                                'username',
                                'password',
                                'password_confirmation');

      // compile the firstName & lastName into a single name property
      data.name = data.firstName + " " + data.lastName;

      // get the model passed from the UserSignupRoute
      user = this.get('model');

      // set the properties for the user based on the data from the form
      user.setProperties(data);

      // Save the user object into the database through the api
      // to understand the Ember.DS (Ember Data) calls to api read more on:
      // http://emberjs.com/guides/models/connecting-to-an-http-server
      user.save().then(function(user) {
        var sessionsController;

        // clear the form data
        _this.setProperties({
          name:                  null,
          email:                 null,
          username:              null,
          password:              null,
          password_confirmation: null
        });

        // get the sessions controller object, defined on line 3
        // and set the properties to proceed to the login action
        sessionsController = _this.get('controllers.sessions');
        sessionsController.setProperties({
          username_or_email: data.username,
          password:          data.password
        });

        // remove the record from the localstorage to avoid duplication on the users list
        // as it will come from the api
        user.deleteRecord();

        // call the loginUser action to authenticate the created user
        sessionsController.send('loginUser');
      }, function(error) {
        // if the api request returns a HTTP status 422 create an errors object to return to the user
        if (error.status === 422) {
          var errs = JSON.parse(error.responseText);
          user.set('errors', errs.errors);
        }
      });
    }
  }
});
