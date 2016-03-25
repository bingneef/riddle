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

      .state 'app',
        abstract: true
        views:
          'navigation':
            controller: 'NavigationController'
            templateUrl: 'app/navigation/navigation.html'
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

    $urlRouterProvider.otherwise '/compass'
