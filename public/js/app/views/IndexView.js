define([
    "ember",
    "text!templates/test.html.erb"
], function(Ember, applicationTemplate) {

    var IndexView = Ember.View.extend({
        defaultTemplate: Ember.Handlebars.compile(applicationTemplate)
    });
    return IndexView;
});
