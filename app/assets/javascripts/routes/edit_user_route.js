// For more information see: http://emberjs.com/guides/routing/

Deerfield.EditUserRoute = Ember.Route.extend({
    model: function(params) {
        return Em.$.ajax({
            url:'/user_data/edit_user',
            type: 'post',
            data:{'user_id': params.id},
            success: function(){

            }
        })
    }
});
