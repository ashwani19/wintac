# For more information see: http://emberjs.com/guides/routing/

IntacWebPortal.Router.map ()->
  @resource 'users', ->
    @resource('users')
  @route 'sign-in'
  @route 'sign-out'

