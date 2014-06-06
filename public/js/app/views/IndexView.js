define([
    "ember",
    "text!templates/IndexTemplate.html"
], function(Ember, applicationTemplate) {

    var IndexView = Ember.View.extend({
        defaultTemplate: Ember.Handlebars.compile(applicationTemplate)
    });
    return IndexView;
});
