define({
    app_name: "intac",
    shim : {
        'ember' : {
            deps: ['handlebars', 'jquery'],
            exports: 'Ember'
        }
    },
    paths : {
        'App': 'app/application',
        'models': 'app/models',
        'views': 'app/views',
        'controllers': 'app/controllers',
        'templates': 'app/templates',
        /*libs*/
        'jquery': 'lib/jquery.2.1.1',
        'handlebars': 'lib/handlebars-v1.3.0',
        'ember': 'libs/ember-1.5.1',
        /*requirejs-plugins*/
        'text': 'lib/requirejs-plugins/text-2.0.12',
        'hbs': 'lib/requirejs-plugins/hbs-0.8.1',
        'domReady': 'libs/requirejs-plugins/domReady-2.0.1',
        'i18n': 'libs/requirejs-plugins/i18n-2.0.4'
    },
    /*hbs plugin options*/
    hbs: {
        disableI18n: true,
        templateExtension: "html"
    }

});
