Deerfield.initApp = function(currentUser) {
    return Deerfield.__container__.lookup('controller:auth').set('currentUser', currentUser);
  };
Ember.Handlebars.helper('datetime', function(value, options) {
    var format = 'D MMMM, YYYY [at] HH:mm';
    if(options.hash.format) {
        format = options.hash.format;
    }
    if(value) {
        var time = moment(value).format(format);
        return new Handlebars.SafeString('<span class="timestamp">' + time + '</span>');
    }
});
Ember.Handlebars.helper('datetime_edit', function(value, options) {
    var format = 'D MMMM, YYYY [at] HH:mm';
    if(options.hash.format) {
        format = options.hash.format;
    }
    if(value) {
        var time = moment(value).format(format);
        return new Handlebars.SafeString(time);
    }
});