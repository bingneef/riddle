angular.module 'App'
  .controller 'HaikuController', ($rootScope, $scope, $timeout, Resources, SocketService) ->
    'ngInject'

    activeLevel = 'haiku'

    $scope.$on 'socketTransmit', (evt, data) ->
      console.log evt, data

    payload = {
      destination: 'slave'
      level: activeLevel
      kind: 'status'
      status: status
    }

    SocketService.socketTransmit(payload)



    console.log 'haiku'

    return
