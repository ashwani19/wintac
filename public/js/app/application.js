define([
    "views/IndexView",
    "controllers/ApplicationController",
    "app/router"
], function(IndexView, ApplicationController, Router){
    /*Module Pattern*/
    var App = {
        ApplicationView: IndexView,
        ApplicationController: ApplicationController,
        Router: Router
    };

    return App;
});
