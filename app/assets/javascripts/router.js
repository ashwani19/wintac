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

Deerfield.AuthenticatedRoute = Ember.Route.extend({
   events: {
    error: function(error, transition) {
      if (error.status === 401) {
        var loginController= this.controllerFor("login");
        var error_message= "You are not authorized to access this page!"
        loginController.set('auth_error_message',error_message);
        loginController.set('attemptedTransition',transition);        
        this.transitionTo('login');
    } 
    else {
        alert('Something went wrong, try later');
    }
}
}

});

Deerfield.UserManagementRoute = Deerfield.AuthenticatedRoute.extend({

    model: function(params) {
        return $.getJSON('/user_data/index');
    }
});
Deerfield.RoleManagementRoute = Deerfield.AuthenticatedRoute.extend({
  model: function(params) {
    return this.store.find('role');
}
});
Deerfield.AddRoleRoute = Ember.Route.extend({
    model: function(params) {
        return params;
    },
    beforeModel: function(transition) {
        if (!this.controllerFor("auth").get("currentUser.email"))
            {
                var loginController= this.controllerFor("login");
                var error_message= "You are not authorized to access this page!"
                loginController.set('auth_error_message',error_message);
                loginController.set('attemptedTransition',transition);        
                this.transitionTo('login');
            }
    }
});
Deerfield.EditRoleRoute = Deerfield.AuthenticatedRoute.extend({
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
Deerfield.EditUserRoute = Deerfield.AuthenticatedRoute.extend({
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
    beforeModel: function(transition) {
        if (this.controllerFor("auth").get("currentUser.email"))
            {
                this.transitionTo("home");
            }
    },
    setupController: function(controller, model) {

          controller.set('content', model);
          setTimeout(function() {
             controller.set('auth_error_message',null);
         }, 5000);
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
