//# for more details see: http://emberjs.com/guides/controllers/

//# for more details see: http://emberjs.com/guides/controllers/

IntacWebPortal.AuthSignInController = Ember.Controller.extend({
  //#email: null
  //#password: null
  //#remember: false

   actions : {
    signIn: function() {
      var controller = this;
      return this.auth.signIn({
        data: {
            email: this.get('email'),
            password: this.get('password'),
            remember: this.get('remember')
          }
      }).fail(function(data) {
        if(data.errors){
          $("#error").html(data.errors)
          alert("sign in failed!");  
        }
        
      }
      );
     
    }
  }
  
  
});


