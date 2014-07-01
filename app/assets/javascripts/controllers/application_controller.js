// for more details see: http://emberjs.com/guides/controllers/



Deerfield.AuthController = Ember.ObjectController.extend({
    currentUser: null,
    isAuthenticated: Em.computed.notEmpty("currentUser.email"),
    login: function(route) {
      var me;
      me = this;
      return $.ajax({
        url: Deerfield.urls.login,
        type: "POST",
        data: {
          "user[email]": route.currentModel.email,
          "user[password]": route.currentModel.password,
          "user[remember_me]": route.currentModel.remember_me
      },
      success: function(data) {
          // log.log("Login Msg " + data.user.dummy_msg);
          me.set('currentUser', data.user);
           //window.location.href="/#/home"
           return route.transitionTo('home');
       },
       error: function(jqXHR, textStatus, errorThrown) {
          if (jqXHR.status === 401) {
            return route.controllerFor('login').set("errorMsg", "That email/password combo didn't work.  Please try again");
        } else if (jqXHR.status === 406) {
            return route.controllerFor('login').set("errorMsg", "Request not acceptable (406):  make sure Devise responds to JSON.");
        } else {
            return p("Login Error: " + jqXHR.status + " | " + errorThrown);
        }
    }
});
  },
  register: function(route) {
      var me;
      me = this;
      return Em.$.ajax({
        url: Deerfield.urls.register,
        type: "POST",
        data: {
          "role": $("#role").val(),
          "company_name" : $("#company_name").val(),
          "user[first_name]": route.currentModel.first_name,
          "user[email]": route.currentModel.email,
          "user[password]": route.currentModel.password,
          "user[password_confirmation]": route.currentModel.password_confirmation

      },
      success: function(data) {
        if (me.get("currentUser"))
        {
            return route.transitionTo('user_management');    
        }
        else{
            return route.transitionTo('home');    
        }
        
},
error: function(jqXHR, textStatus, errorThrown) {
  return route.controllerFor('registration').set("errorMsg", "That email/password combo didn't work.  Please try again");
}
});
  },
  logout: function() {
      var me;
      log.info("Logging out...");
      me = this;
      return $.ajax({
        url: Deerfield.urls.logout,
        type: "DELETE",
        dataType: "json",
        success: function(data, textStatus, jqXHR) {
          $('meta[name="csrf-token"]').attr('content', data['csrf-token']);
          $('meta[name="csrf-param"]').attr('content', data['csrf-param']);
          log.info("Logged out on server");
          me.set('currentUser', null);
          return me.transitionToRoute("home");
      },
      error: function(jqXHR, textStatus, errorThrown) {
          return alert("Error logging out: " + errorThrown);
        }
      });
    }
  });

Deerfield.NavbarController = Ember.ObjectController.extend({
    needs: ['auth'],
    isAuthenticated: Em.computed.alias("controllers.auth.isAuthenticated"),
    user: Em.computed.alias("controllers.auth.currentUser"),
    hiName: Em.computed.any("user.first_name", "user.email"),
    role: Em.computed.any("user.role"),
    actions: {
      logout: function() {
        log.info("NavbarController handling logout event...");
        return this.get("controllers.auth").logout();
    }
},
check_role_admin: function() {
    return (this.get('role') === 'admin' );
}.property('role'),
check_role_user: function() {
    return (this.get('role') === 'user' );
}.property('role'),
check_role_admin_user: function() {
    return (this.get('role') === 'admin' || this.get('role') === 'employee'|| this.get('role') === 'customer' );
}.property('role'),
check_role_user: function() {
  return ( this.get('role') === 'employee'|| this.get('role') === 'customer' );
}.property('role')

});

Deerfield.WelcomeMsgController = Ember.ObjectController.extend({
    needs: ['auth'],
    isAuthenticated: Em.computed.alias("controllers.auth.isAuthenticated"),
    user: Em.computed.alias("controllers.auth.currentUser"),
    hiName: Em.computed.any("user.first_name", "user.email"),
    role: Em.computed.any("user.role")
});

Deerfield.ApplicationController = Ember.Controller.extend({
	needs: ['auth'],
    isAuthenticated: Em.computed.alias("controllers.auth.isAuthenticated"),
    user: Em.computed.alias("controllers.auth.currentUser"),
    hiName: Em.computed.any("user.first_name", "user.email"),
    role: Em.computed.any("user.role"),
    check_role_admin: function() {
        return (this.get('role') === 'admin' );
    }.property('role'),
    check_role_user: function() {
        return (this.get('role') === 'user' );
    }.property('role'),
    check_role_admin_user: function() {
        return (this.get('role') === 'admin' || this.get('role') === 'employee'|| this.get('role') === 'customer' );
    }.property('role')

});
Deerfield.UpdateUserController = Ember.Controller.extend({
    needs: ['auth'],
    isAuthenticated: Em.computed.alias("controllers.auth.isAuthenticated"),
    user:   Em.computed.alias("controllers.auth.currentUser"),
    hiName: Em.computed.any("user.first_name", "user.email"),
    email:  Em.computed.any("user.email"),
    role: Em.computed.any("user.role"),
    check_role_admin: function() {
        return (this.get('role') === 'admin' );
    }.property('role'),
    check_role_user: function() {
        return ( this.get('role') === 'employee'|| this.get('role') === 'customer' );
    }.property('role'),
    check_role_admin_user: function() {
        return (this.get('role') === 'admin' || this.get('role') === 'employee'|| this.get('role') === 'customer' );
    }.property('role')

});

Deerfield.RoleManagementController = Ember.ArrayController.extend({
    needs: ['auth'],
    assignIndex:function(){
        this.map(function(item,index){Em.set(item,'index',index+1)})
    }.observes('content.[]','firstObject','lastObject'),
    isAuthenticated: Em.computed.alias("controllers.auth.isAuthenticated"),
    user:   Em.computed.alias("controllers.auth.currentUser"),
    hiName: Em.computed.any("user.first_name", "user.email"),
    email:  Em.computed.any("user.email"),
    role: Em.computed.any("user.role"),
    check_role_admin: function() {
        return (this.get('role') === 'admin' );
    }.property('role'),
    check_role_user: function() {
        return ( this.get('role') === 'employee'|| this.get('role') === 'customer' );
    }.property('role'),
    check_role_admin_user: function() {
        return (this.get('role') === 'admin' || this.get('role') === 'employee'|| this.get('role') === 'customer' );
    }.property('role'),
    actions: {
        search_role: function(){
            var me = this;
            return Em.$.ajax({
                url: 'roles/search_roles.json',
                type: "GET",
                data: {
                    "search_word": $("#keyword").val(),
                    "search_type": $("#role_mode").val()
                },
                success: function(data) {
                    if ($.isEmptyObject(data.role_list)==false){
                        me.set("role_list",data.role_list);
                    }
                    else{
                        me.set("role_list",null);
                    }

                },
                error: function(jqXHR, textStatus, errorThrown) {
                    return route.controllerFor('registration').set("errorMsg", "Sorry ! try later");
                }
            });
        }
    }

});
Deerfield.UserManagementController = Ember.ObjectController.extend({
 needs: ['auth'],
 isAuthenticated: Em.computed.alias("controllers.auth.isAuthenticated"),
 user:   Em.computed.alias("controllers.auth.currentUser"),
 hiName: Em.computed.any("user.first_name", "user.email"),
 email:  Em.computed.any("user.email"),
 active:Em.computed.any("user.is_active"),
 role: Em.computed.any("user.role"),
 check_role_admin: function() {
 return (this.get('role') === 'admin' );
 }.property('role'),
 check_role_user: function() {
 return ( this.get('role') === 'employee'|| this.get('role') === 'customer' );
 }.property('role'),
  check_role_admin_user: function() {
          return (this.get('role') === 'admin' || this.get('role') === 'employee'|| this.get('role') === 'customer' );
    }.property('role'),
        actions:{
        search_user: function(route){
            var me = this;
            return Em.$.ajax({
                url: '/search_users.json',
                type: "GET",
                data: {
                    "search_word": $("#keyword").val(),
                    "search_type": $("#mode").val()
                },
                success: function(data) {
                    if ($.isEmptyObject(data.json_sessions)==false){
                        me.set("user_data",data.json_sessions);
                    }
                    else{
                        me.set("user_data",null);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    return route.controllerFor('registration').set("errorMsg", "Sorry ! try later");
                }
            });
        }
    }
  });

Deerfield.UsersPasswordEditController = Ember.ObjectController.extend({
    actions: {
        createPassword: function (route) {
            var me;
            me = this;
            if($("#password").val()=='' || $("#password_confirmation").val()=='' )
            {
                $("#error_show").html("Fill password!");
            }else if ($("#password").val().length <=6)
            {
                $("#error_show").html("Passwords length should be atleast 6 characters!");
            }else if( $("#password").val()!=$("#password_confirmation").val())
            {
                $("#error_show").html("Passwords mismatch!")
            }

            else
            {
                $("#error_show").html("");
                return Em.$.ajax({
                    url:  Deerfield.urls.reset_password,
                    type: "POST",
                    data: {
                        "user[reset_password_token]": $("#reset_password_token").val(),
                        "user[password]":  $("#password").val(),
                        "user[password_confirm]" : $("#password_confirmation").val()

                    },
                    success: function (data) {
                        if (data.error)
                        {
                            alert(error);
                        }
                        else if (data.success)
                        {
                            alert(data.success);
                            return me.transitionTo('home');
                        }
                        else if(data.password_e)
                        {
                            alert(data.password_e);
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        return route.controllerFor('registration').set("errorMsg", "There is some error try after some time!");
                    }
                });
}


}
}
});

Deerfield.PasswordResetController = Ember.ObjectController.extend({
    actions: {
        passwordReset: function(route) {
            var me;
            me = this;
            return Em.$.ajax({
                url: '/users/password',
                type: "POST",
                data: {
                    "user[email]": $("#email").val()
                },
                success: function(data) {
                    alert(data.message);
                    return me.transitionTo('home');
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    return route.controllerFor('registration').set("errorMsg", "That email/password combo didn't work.  Please try again");
                }
            });

        }
    }
});
Deerfield.EditUserController = Ember.ObjectController.extend({

    role: Em.computed.any("user.user_type"),
    check_role_employee: function() {
        return ( this.get('role') === 'employee' );
    }.property('role'),
    check_role_customer: function() {
        return ( this.get('role') === 'customer' );
    }.property('role'),
    actions: {
        editUser: function() {
        var me=this;
            Em.$.ajax({
                url: "/user_data/update_user",
                type: 'get',
                data: {
                    'user_id': $("#user_id").val(),
                    'first_name' : $("#first_name").val(),
                    'last_name' : $("#last_name").val(),
                    'customer[name]' : $("#first_name").val(),
                    'customer[address1]' : $("#addres").val(),
                    'customer[state]' : $("#state").val(),
                    'customer[zip]' : $("#zip").val(),
                    'customer[city]' : $("#city").val(),
                    'customer[business]' : $("#business").val(),
                    'customer[company_name]': $("#company_name").val(),
                    'customer[phone1]': $("#phone1").val(),
                    'customer[phone2]': $("#phone2").val(),
                    'customer[salutation]': $("#salutation").val(),
                    'customer[county]': $("#county").val()
                },
                success: function(){
                   return me.transitionToRoute("user_management");
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    return route.controllerFor('registration').set("errorMsg", "Not submit Please try again");
                }
            })
        },
        employee: function(){
            var me=this;
          var data= new FormData($('#myForm')[0])
            return Em.$.ajax({
            url: '/employees/update_row',
            type: "POST",
            processData: false,
             contentType: false,
             data: data,
             success: function(){
                return me.transitionToRoute('user_management');
             },
                error: function(jqXHR, textStatus, errorThrown) {
                    return me.controllerFor('registration').set("errorMsg", "Not submit Please try again");
                } 
             }) 
        }
           

    }
});

Deerfield.AddRoleController = Ember.ObjectController.extend({
    actions: {
       create_role: function(route){
        var me;
        me = this;
        if ($("#role_name").val()=='' ){
            $("#error_message").html("Add Role Name");
        }
        else if ($("#role_description").val()==''){
            $("#error_message").html("Add Role Description");
        }
        else{
            $("#error_message").html("");
         return Em.$.ajax({
            url: '/roles/create',
            type: "POST",
            data: {
                "role[name]": $("#role_name").val(),
                "role[description]": $("#role_description").val()
            },
            success: function(data) {
                alert(data.message);
                return me.transitionTo('role_management');
            },
            error: function(jqXHR, textStatus, errorThrown) {
             return route.controllerFor('add_role').set("errorMsg", "Sorry! try later");
         }
     }); 
     }

 }
}
});
Deerfield.EditRoleController = Ember.ObjectController.extend({
    actions: {
       update_role: function(route){
        var me;
        me = this;
        if ($("#role_name").val()=='' ){
            $("#error_message").html("Add Role Name");
        }
        else if ($("#role_description").val()==''){
            $("#error_message").html("Add Role Description");
        }
        else{
            $("#error_message").html("");
         return Em.$.ajax({
            url: '/roles/update',
            type: "POST",
            data: {
                "id": $("#role_id").val(),
                "role[name]": $("#role_name").val(),
                "role[description]": $("#role_description").val()
            },
            success: function(data) {
                alert(data.message);
                return me.transitionTo('role_management');
            },
            error: function(jqXHR, textStatus, errorThrown) {
             return route.controllerFor('add_role').set("errorMsg", "Sorry! try later");
         }
     }); 
     }

 }
}
});

