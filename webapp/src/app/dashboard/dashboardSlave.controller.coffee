angular.module 'App'
  .controller 'DashboardSlaveController', ($rootScope, $scope, $timeout, SocketService) ->
    'ngInject'

    console.log 'dashboardSlave'

    $scope.$on 'socketTransmit', (evt, data) ->
      console.log evt, data

    activeLevel = 'dashboard'
    payload = {
      destination: 'host'
      level: activeLevel
    }

    $timeout ->
      SocketService.socketTransmit(payload)
    , 1000

    return
