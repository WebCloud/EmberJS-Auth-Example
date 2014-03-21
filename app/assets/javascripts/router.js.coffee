Auth.Router.map ()->
  @resource('sessions', ()->
    @route('logout')
    @route('login')
    return
  )
  @resource('users', ()->
    @route('signup')
    @route('user',{path:'/user/:user_id'})
    return
  )
  @route('secret')
  return
