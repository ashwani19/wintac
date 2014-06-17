# For more information see: http://emberjs.com/guides/routing/



IntacWebPortal.UsersRoute = Em.Route.extend
  authRedirectable: true
  serialize: (model) ->
    #user_id: model.get 'email'
    @store.filter 'user', (user)->
      user.get('user_type') != "admin"
IntacWebPortal.UsersIndexRoute = Em.Route.extend
  model: ->
    @store.findQuery 'user'
     

IntacWebPortal.UsersShowRoute = Em.Route.extend
  serialize: (model) ->
    #user_id: model.get 'email'
    @store.filter 'user', (user)->
      user.get('user_type') != "admin"