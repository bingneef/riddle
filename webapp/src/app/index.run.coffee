angular.module 'App'
  .run ($log, $rootScope, $state, $timeout, SocketService) ->
    'ngInject'
    $log.debug 'runBlock end'

    SocketService.initiate()

    $rootScope.levels = [
      {
        key: 'haiku'
        name: 'Haiku'
      }
      {
        key: 'compass'
        name: 'Compass'
      }
    ]

    $rootScope.currentLevel = 0


    $rootScope.nextLevel = ->
      $rootScope.currentLevel += 1
      $state.go('app.' + $rootScope.levels[$rootScope.currentLevel].key)
