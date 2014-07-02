Deerfield.UserManagementView = Ember.View.extend({
	didInsertElement : function(){
		this._super();
		Ember.run.scheduleOnce('afterRender', this, function(){

			$('#select-all').click(function(event) {
				if(this.checked) {
		        $(':checkbox').each(function() {
		        	this.checked = true;
		        });
		    }
		    else
		    {
		    	$(':checkbox').each(function() {
		    		this.checked = false;
		    	});
		    }
		});

		});
	}
});