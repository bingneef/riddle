angular.module 'App'
  .run ($rootScope, $log, LoginService) ->
    'ngInject'
    $log.debug 'runBlock end'

    $rootScope.$on '$stateChangeStart', () ->
      LoginService.authenticate()


