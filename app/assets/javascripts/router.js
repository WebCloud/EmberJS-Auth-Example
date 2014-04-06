
Auth.Router.map(function() {
  this.resource('sessions', function() {
    this.route('logout');
    this.route('login');
  });
  this.resource('users', function() {
    this.route('signup');
    this.route('user', {
      path: '/user/:user_id'
    });
  });
  this.route('secret');
});
