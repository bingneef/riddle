angular.module 'App'
  .controller 'CompassController', ($rootScope, $scope, $timeout, SocketService, SweetAlert) ->
    'ngInject'

    sequence = [0, 180, 90, 270]
    sequenceMargin = 15
    sequenceStep = 0

    activeLevel = 'compass'

    $scope.start = ->
      payload = {
        level: activeLevel
        kind: 'level'
        value: activeLevel
      }
      SocketService.masterTransmit(payload)


    SweetAlert.swal({
      title: "Start level!"
      text: "Make sure your phone is on!"
      type:"info"}
      , ->
        $scope.start()
      )


    $scope.sendStatus = (status) ->
      payload = {
        level: activeLevel
        kind: 'status'
        status: status
      }
      SocketService.masterTransmit(payload)

    $scope.requestOrientation = ->
      payload = {
        level: activeLevel
        kind: 'requestOrientation'
      }
      SocketService.masterTransmit(payload)



    $rootScope.$on('slaveIncoming', (event, data) ->
      switch data.kind
        when 'orientation'
          checkOrientatation(data.state)

    )

    checkOrientatation = (state) ->
      correctOrientation = false
      switch sequence[sequenceStep]
        when 0
          if state > 345 || state < 15
            correctOrientation = true
        else
          if state > sequence[sequenceStep] - sequenceMargin && state < sequence[sequenceStep] + sequenceMargin
            correctOrientation = true

      if correctOrientation
        $scope.sendStatus('success')
        sequenceStep++
      else
        $scope.sendStatus('error')

      if sequenceStep == sequence.length
        SweetAlert.swal({
          title: "Good job!"
          text: "You finished the level!"
          type:"success"}
          , ->
            $rootScope.nextLevel()
          )


    return
