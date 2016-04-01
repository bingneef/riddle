angular.module 'App'
  .controller 'CompassController', ($rootScope, $scope, $state, $window, $timeout, $interval, SocketService, SweetAlert) ->
    'ngInject'

    $scope.status = {}
    activeLevel = 'compass'
    $scope.code = ''

    $scope.start = ->
      payload = {
        level: activeLevel
        kind: 'level'
        value: activeLevel
      }
      SocketService.masterTransmit(payload)

    $scope.start()

    $scope.angles = [45, 225, 135, 315]
    $scope.correctAngles = 0
    currentAngleStep = 0
    angleOffset = 22.5

    $rootScope.$on('slaveIncoming', (event, data) ->
      if data.kind == 'level'
        $state.go('slave.' + data.value)
        return

      return unless data.level == activeLevel
      switch data.kind
        when 'arrowClick'
          checkAngle(data.angle)
    )

    $scope.$watch 'code', (newValue, oldValue) ->
      return if oldValue.length >= newValue.length || newValue.length == 0

      solution = 'nsew'
      status = 'error'

      if solution.indexOf($scope.code.toLowerCase()) == 0
        status = 'success'
        if $scope.code.toLowerCase() == solution
          alert("succes")

      SocketService.masterTransmit({level: activeLevel, kind: 'status', value: status})

    $interval ->
      currentAngleStep++
      if currentAngleStep >= $scope.angles.length then currentAngleStep = 0
    , 2000


    $scope.arrowStyle = ->
      {
        'transform': 'rotate(' + $scope.angles[currentAngleStep] + 'deg)'
      }

    checkAngle = (angle) ->
      status = 'error'
      console.log $scope.angles[$scope.correctAngles] - angleOffset, $scope.angles[$scope.correctAngles] + angleOffset
      if angle > $scope.angles[$scope.correctAngles] - angleOffset && angle < $scope.angles[$scope.correctAngles] + angleOffset
        status = 'success'
        $scope.correctAngles++

        if $scope.correctAngles > $scope.angles.length - 1
          console.log 'level done'
      else
        status = 'error'
        $scope.correctAngles = 0

      SocketService.masterTransmit({level: activeLevel, kind: 'status', value: status})


    return

