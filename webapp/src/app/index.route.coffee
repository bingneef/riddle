angular.module 'App'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'slave',
        abstract: true
      .state 'slave.compass',
        url: '/slave/compass'
        views:
          '@':
            templateUrl: 'app/compass/compass_slave.html'
            controller: 'CompassSlaveController'
            controllerAs: 'compass_slave'
      .state 'slave.haiku',
        url: '/slave/haiku'
        views:
          '@':
            templateUrl: 'app/haiku/haiku_slave.html'
            controller: 'HaikuSlaveController'
            controllerAs: 'haiku_slave'
      .state 'slave.numbers',
        url: '/slave/numbers'
        views:
          '@':
            templateUrl: 'app/numbers/numbers_slave.html'
            controller: 'NumbersSlaveController'
            controllerAs: 'numbers_slave'
      .state 'slave.duckhunt',
        url: '/slave/duckhunt'
        views:
          '@':
            templateUrl: 'app/duckhunt/duckhunt_slave.html'
            controller: 'DuckhuntSlaveController'
            controllerAs: 'duckhunt_slave'
      .state 'slave.dashboard',
        url: '/slave/dashboard'
        views:
          '@':
            templateUrl: 'app/dashboard/dashboard-slave.html'
            controller: 'DashboardSlaveController'
            controllerAs: 'dashboardSlave'

      .state 'fs',
        abstract: true

      .state 'fs.login',
        url: '/login'
        views:
          '@':
            templateUrl: 'app/login/login.html'
            controller: 'LoginController'
            controllerAs: 'login'

      .state 'fs.oauth2',
        url: '/oauth2'
        views:
          '@':
            templateUrl: 'app/login/oauth2.html'
            controller: 'Oauth2Controller'
            controllerAs: 'Oauth2'

      .state 'app',
        abstract: true
        views:
          'navigation':
            controller: 'NavigationController'
            templateUrl: 'app/navigation/navigation.html'
      .state 'app.dashboard',
        url: '/dashboard'
        views:
          '@':
            templateUrl: 'app/dashboard/dashboard.html'
            controller: 'DashboardController'
            controllerAs: 'dashboard'
      .state 'app.compass',
        url: '/compass'
        views:
          '@':
            templateUrl: 'app/compass/compass.html'
            controller: 'CompassController'
            controllerAs: 'compass'
      .state 'app.haiku',
        url: '/haiku'
        views:
          '@':
            templateUrl: 'app/haiku/haiku.html'
            controller: 'HaikuController'
            controllerAs: 'haiku'
      .state 'app.numbers',
        url: '/numbers'
        views:
          '@':
            templateUrl: 'app/numbers/numbers.html'
            controller: 'NumbersController'
            controllerAs: 'numbers'
      .state 'app.duckhunt',
        url: '/duckhunt'
        views:
          '@':
            templateUrl: 'app/duckhunt/duckhunt.html'
            controller: 'DuckhuntController'
            controllerAs: 'duckhunt'

    $urlRouterProvider.otherwise '/dashboard'
