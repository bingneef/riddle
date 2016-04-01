angular.module 'App'
  .controller 'CompassSlaveController', ($rootScope, $scope, $state, $window, $timeout, $interval, SocketService, SweetAlert) ->
    'ngInject'

    $scope.status = {}
    activeLevel = 'compass'

    $scope.arrowStyle = ->
      {
        'transform': 'rotate(' + $scope.displayOrientation + 'deg)'
      }

    $scope.$watch('orientation', (newValue, oldValue) ->
      if Math.abs(newValue - oldValue) > 1 || !oldValue?
        $scope.displayOrientation = newValue
    )

    $rootScope.$on('masterIncoming', (event, data) ->
      if data.kind == 'level'
        $state.go('slave.' + data.value)
        return

      return unless data.level == activeLevel

      switch data.kind
        when 'status'
          paintBackground(data.value)
    )

    $scope.compassClick = ->
      SocketService.slaveTransmit({level: activeLevel, kind: 'arrowClick', angle: $scope.displayOrientation})

    paintBackground = (status) ->
      $scope.status.color = status
      $timeout.cancel(timeout) if timeout?
      timeout = $timeout ->
        $scope.status.color = undefined
      , 1000

    $window.ondeviceorientation = (event) ->
      $scope.orientation = event.alpha
      $scope.$apply()

    return
