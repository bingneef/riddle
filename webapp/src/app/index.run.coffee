angular.module 'App'
  .run ($rootScope, $log, LoginService) ->
    'ngInject'
    $log.debug 'runBlock end'

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options) ->
      if toState.name.indexOf('slave') == 0
        $rootScope.socketRole = 'slave'
      else
        $rootScope.socketRole = 'host'

      LoginService.authenticate()


