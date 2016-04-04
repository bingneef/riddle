angular.module 'App'
  .controller 'HaikuController', ($rootScope, $scope, $timeout, Resources, SocketService) ->
    'ngInject'

    activeLevel = 'haiku'

    $scope.start = ->
      payload = {
        level: activeLevel
        kind: 'level'
        value: activeLevel
      }
      SocketService.masterTransmit(payload)

    $scope.start()

    $scope.answer = ''

    $scope.checkAnswer = ->
      if $scope.answer.toLowerCase().trim() == 'lisanne'
        sendStatus('success')
        $timeout ->
          $rootScope.nextLevel()
        , 1000
      else
        sendStatus('error')

    sendStatus = (status) ->
      payload = {
        level: activeLevel
        kind: 'status'
        status: status
      }

      SocketService.masterTransmit(payload)



    console.log 'haiku'

    return
