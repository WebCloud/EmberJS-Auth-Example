// for more details see: http://emberjs.com/guides/controllers/

Auth.SessionsController = Ember.Controller.extend({
  // initialization method to verify if there is a access_token cookie set
  // so we can set our ajax header with it to access the protected pages
  init: function() {
    this._super();
    if (Ember.$.cookie('access_token')) {
      Ember.$.ajaxSetup({
        headers: {
          'Authorization': 'Bearer ' + Ember.$.cookie('access_token')
        }
      });
    }
  },

  // overwriting the default attemptedTransition attribute from the Ember.Controller object
  attemptedTransition: null,

  // create and set the token & current user objects based on the respective cookies
  token:               Ember.$.cookie('access_token'),
  currentUser:         Ember.$.cookie('auth_user'),

  // create a observer binded to the token property of this controller
  // to set/remove the authentication tokens
  tokenChanged: (function() {
    if (Ember.isEmpty(this.get('token'))) {
      Ember.$.removeCookie('access_token');
      Ember.$.removeCookie('auth_user');
    } else {
      Ember.$.cookie('access_token', this.get('token'));
      Ember.$.cookie('auth_user', this.get('currentUser'));
    }
  }).observes('token'),

  // reset the controller properties and the ajax header
  reset: function() {
    this.setProperties({
      username_or_email: null,
      password:          null,
      token:             null,
      currentUser:       null
    });
    Ember.$.ajaxSetup({
      headers: {
        'Authorization': 'Bearer none'
      }
    });
  },
  actions:              {
    // login action
    loginUser: function() {
      var _this = this;

      // get the properties sent from the form and if there is any attemptedTransition set
      var attemptedTrans = this.get('attemptedTransition');
      var data =           this.getProperties('username_or_email', 'password');

      // clear the form fields
      this.setProperties({
        username_or_email: null,
        password:          null
      });

      // send a POST request to the /sessions api with the form data
      Ember.$.post('/session', data).then(function(response) {
          var key;

          // set the ajax header with the returned access_token object
          Ember.$.ajaxSetup({
            headers: {
              'Authorization': 'Bearer ' + response.api_key.access_token
            }
          });

          // create a apiKey record on the local storage based on the returned object
          key = _this.get('store').createRecord('apiKey', {
            accessToken: response.api_key.access_token
          });

          // find a user based on the user_id returned from the request to the /sessions api
          _this.store.find('user', response.api_key.user_id).then(function(user) {

            // set this controller token & current user properties
            // based on the data from the user and access_token
            _this.setProperties({
              token:       response.api_key.access_token,
              currentUser: user.getProperties('username', 'name', 'email')
            });

            // set the relationship between the User and the ApiKey models & save the apiKey object
            key.set('user', user);
            key.save();

            user.get('apiKeys').content.push(key);

            // check if there is any attemptedTransition to retry it or go to the secret route
            if (attemptedTrans) {
              attemptedTrans.retry();
              _this.set('attemptedTransition', null);
            } else {
              _this.transitionToRoute('secret');
            }

          });
        }, function(error) {
        if (error.status === 401) {
          // if there is a authentication error the user is informed of it to try again
          alert("wrong user or password, please try again");
        }
      });
    }
  }
});
