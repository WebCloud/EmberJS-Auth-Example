Auth.SecretRoute = Auth.AuthenticatedRoute.extend
  model: ()->
    @store.find('user');
