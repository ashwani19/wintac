// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.form
//= require jquery_ujs

//= require bootstrap
//= require bootstrap-datepicker
//= require moment
//= require handlebars
//= require ember
//= require ember-data
//= require_self
//= require ./deerfield

// for more details see: http://emberjs.com/guides/application/
Deerfield = Ember.Application.create();

//= require_tree .


$( document ).ready(function() {
    $(document).on("change","#mode",function(){
        if($(this).val()=="active" || $(this).val()=="inactive"){
            $("#keyword").prop("disabled",true);
        }
        else
        {
            $("#keyword").prop("disabled",false);
        }
        
    })
});

function validate_registration_form(){
    var decision = true;
    if($("#role").val()=='employee')
    {
        if($("#name").val().length==0)
        {
            $("#emp_name_error").html("Please enter name!")
            decision = false;
        }
        else{
            $("#emp_name_error").html("")
        }
    }
    else if($("#role").val()=='customer'){
        if($("#company_name").val().length==0)
        {
            $("#cust_name_error").html("Please enter Company name!");
            decision = false;
        }
        else{
            $("#cust_name_error").html("")
        }
         if($("#name").val().length==0)
        {
            $("#emp_name_error").html("Please enter name!")
            decision = false;
        }
        else{
            $("#emp_name_error").html("")
        }
    }
    var emailRegex = new RegExp(/^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$/i);
    var valid = emailRegex.test($("#email").val());
    if(!valid){
        $("#email_error").html("Please enter a valid email address!");
        decision = false;
    }
    else{
        $("#email_error").html("")
    }


    if($("#password").val().length<6){
        $("#pass_error").html("Please enter minimum 6 characters!");
        decision = false;
    }
    else{
        $("#pass_error").html("")
    }


    if($("#password_confirmation").val()!= $("#password").val()){
        $("#pass_match_error").html("Passwords not matching!");
        decision = false;
    }
    else{
        $("#pass_match_error").html("")
    }

    return decision;
}

function validate_login_form(){
	var decision = true;
    var emailRegex = new RegExp(/^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$/i);
 	var valid = emailRegex.test($("#email").val());
    if(!valid){
    	$("#email_error").html("Please enter a valid email address!");
    	decision = false;
    }
    else{
		$("#email_error").html("")
	}


    if($("#password").val().length<=0){
    	$("#password_error").html("Please enter password to login!");
    	decision = false;
    }
    else{
		$("#password_error").html("")
	}


    return decision;
}