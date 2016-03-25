angular.module 'App'
  .controller 'CompassSlaveController', ($rootScope, $scope, $state, $window, $timeout, SocketService) ->
    'ngInject'

    $scope.status = {}
    $scope.isFullScreen = false

    activeLevel = 'compass'

    $rootScope.$on('masterIncoming', (event, data) ->
      if data.kind == 'level'
        $state.go('slave.' + data.value)
        return

      return unless data.level == activeLevel

      switch data.kind
        when 'level'
          $state.go('slave.' + data.value)
        when 'status'
          paintBackground(data.status)
        when 'requestOrientation'
          payload = {
            kind: 'orientation'
            state: $scope.orientation
          }
          SocketService.slaveTransmit(payload)
    )

    paintBackground = (status) ->
      $scope.status.color = status
      $timeout ->
        $scope.status.color = undefined
      , 1000
      $scope.$apply()

    $scope.goFullScreen = ($event) ->
      $scope.isFullScreen = true
      document.getElementById("control").webkitRequestFullscreen()

    $window.ondeviceorientation = (event) ->
      $scope.orientation = event.alpha
      $scope.$apply()

    return
