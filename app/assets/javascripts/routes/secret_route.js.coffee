# For more information see: http://emberjs.com/guides/routing/

Auth.SecretRoute = Auth.AuthenticatedRoute.extend
  model: ()->
    # instantiate the model for the SecretController as a list of created users
    @store.find('user');
