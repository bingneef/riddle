angular.module 'App'
  .controller 'DuckhuntSlaveController', ($rootScope, $scope, $state, $window, $timeout, $interval, SocketService, SweetAlert) ->
    'ngInject'
    $scope.status = {}
    activeLevel = 'duckhunt'

    $scope.$watch 'orientation', (newValue, oldValue) ->
      payload =
        level: activeLevel
        destination: 'host'
        kind: 'orientation'
        value: newValue

      SocketService.socketTransmit payload
    , true

    $scope.fireClick = ->
      payload =
        level: activeLevel
        destination: 'host'
        kind: 'fire'

      SocketService.socketTransmit payload

    $window.ondeviceorientation = (event) ->
      # $scope.drawingTimeout = $timeout ->
      $scope.orientation =
        alpha: 2 * Math.PI * event.alpha / 360
        beta: 2 * Math.PI * event.beta / 360
        gamma: 2 * Math.PI * event.gamma / 360

      $scope.$apply()

    return
