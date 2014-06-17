# for more details see: http://emberjs.com/guides/controllers/

IntacWebPortal.AuthSignOutController = Ember.Controller.extend({
  actions:
    signOut: ->
      @auth.signOut().then -> window.location.reload true
})

