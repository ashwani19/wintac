// For more information see: http://emberjs.com/guides/routing/

Deerfield.Router.map(function() {
    this.resource('user_management',{path:'/user_management'});
    this.route("home");
    this.route("help");
    this.route("login");
    this.route("add_role");
    this.route("edit_role",{path:'/edit_role/:id'});
    this.route("update_user");
    this.resource("edit_user",{path: '/users/:id/edit'})
    this.route("password_reset");
    this.resource('users_password_edit', {path: "/users/password/edit/:reset_password_token"});
        //this.route('user_management');
        this.route('role_management');
        return this.route("registration");
    });

Deerfield.UserManagementRoute = Ember.Route.extend({
    model: function(params) {
        return Em.$.ajax({
            type: 'get',
            url:'/user_data/index',
            success : function(){

            }
        });
    }
});
Deerfield.RoleManagementRoute = Ember.Route.extend({
      model: function(params) {
        return this.store.find('role');
    }
});
Deerfield.AddRoleRoute = Ember.Route.extend({
    model: function(params) {
        return params;
    }
});
Deerfield.EditRoleRoute = Ember.Route.extend({
    model: function(params) {
     return Em.$.ajax({
            type: 'get',
            url:'/roles/edit',
            data:{
                id: params.id
            },
            success : function(){

            }
        });
    }
});
Deerfield.UsersPasswordEditRoute = Ember.Route.extend({
    model: function(params) {
        return {token: params.reset_password_token}
    },
    setupController: function(controller, model) {
        controller.set('content', model.token);
    }

});
Deerfield.PasswordResetRoute = Ember.Route.extend({
    model: function(params) {
        return params;
    }
});
Deerfield.IndexRoute = Ember.Route.extend({
    beforeModel: function(transition) {
        return this.transitionTo('home');
    }
});

Deerfield.LoginRoute = Ember.Route.extend({
    model: function() {
        return Ember.Object.create();
    },
    setupController: function(controller, model) {
        controller.set('content', model);
        return controller.set("errorMsg", "");
    },
    actions: {
        login: function() {
            log.info("Logging in...");
            return this.controllerFor("auth").login(this);
        },
        cancel: function() {
            log.info("cancelling login");
            return this.transitionToRoute('home');
        }
    }
});

Deerfield.RegistrationRoute = Ember.Route.extend({
    model: function() {
        return Ember.Object.create();
    },
    actions: {
        register: function() {
            log.info("Registering...");
            return this.controllerFor("auth").register(this);
        },
        cancel: function() {
            log.info("cancelling registration");
            return this.transitionTo('user_management');
        }
    }
});
