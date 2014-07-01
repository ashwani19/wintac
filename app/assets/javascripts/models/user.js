// for more details see: http://emberjs.com/guides/models/defining-models/

Deerfield.User = DS.Model.extend({
    first_name: DS.attr('string'),
    address: DS.attr('string'),
    user_type: DS.attr('string'),
    created_at: DS.attr('date'),
   email: DS.attr('string')
});
