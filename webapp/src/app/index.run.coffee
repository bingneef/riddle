angular.module 'App'
  .run ($rootScope, $log, LoginService, SocketService) ->
    'ngInject'
    $log.debug 'runBlock end'

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options) ->
      if toState.name.indexOf('slave') == 0
        $rootScope.socketRole = 'slave'
      else
        $rootScope.socketRole = 'host'

    SocketService.initiate({room: 'testtest'})

    LoginService.authenticate() unless toState.name.indexOf('oauth2') > -1


