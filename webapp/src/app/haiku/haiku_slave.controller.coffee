angular.module 'App'
  .controller 'HaikuSlaveController', ($rootScope, $scope, $state, $window, $timeout, SocketService) ->
    'ngInject'

    activeLevel = 'haiku'
    $scope.status = {}

    $rootScope.$on('masterIncoming', (event, data) ->
      if data.kind == 'level'
        $state.go('slave.' + data.value)
        return

      return unless data.level == activeLevel

      switch data.kind
        when 'status'
          paintBackground(data.status)
    )

    paintBackground = (status) ->
      $scope.status.color = status
      $timeout ->
        $scope.status.color = undefined
      , 1000
      $scope.$apply()


    return
