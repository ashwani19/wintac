Deerfield.EditUserView = Ember.View.extend({
 didInsertElement : function(){
    this._super();
    Ember.run.scheduleOnce('afterRender', this, function(){
            setTimeout(function() {
                $("#active_ref_code").prop("value",$("#ref_code_data").val())
            }, 500);
            $('.date').datepicker({format: 'dd/mm/yyyy'});

       
    });
  }
});