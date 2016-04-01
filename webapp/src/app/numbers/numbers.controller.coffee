angular.module 'App'
  .controller 'NumbersController', ($rootScope, $scope, $state, $window, $timeout, $interval, SocketService, SweetAlert) ->
    'ngInject'

    $scope.status = {}
    activeLevel = 'numbers'
    $scope.answerCode = 'iloveyou'
    $scope.correctTiles = false
    $scope.userInputCode = ''

    $scope.$watch 'userInputCode', ->
      unless $scope.correctTiles
        $scope.codeStatus = ''
        return

      if $scope.userInputCode.length == 0
        $scope.codeStatus = ''
      else if angular.equals($scope.userInputCode.toLowerCase().replace(/ /g,''), $scope.answerCode)
        $scope.codeStatus = 'success'
      else
        $scope.codeStatus = 'error'

    $scope.start = ->
      payload = {
        kind: 'level'
        value: activeLevel
      }
      SocketService.masterTransmit(payload)

    $scope.start()

    $scope.answerTotal =
      sum: 4181
      count: 8

    $rootScope.$on('slaveIncoming', (event, data) ->
      if data.kind == 'level'
        $state.go('slave.' + data.value)
        return

      return unless data.level == activeLevel
      switch data.kind
        when 'tileStatus'
          $scope.tiles = data.tiles
          $scope.$apply()
    )

    $scope.$watch 'tiles', ->
      $scope.tilesCount = 0
      $scope.tilesSum = 0
      angular.forEach $scope.tiles, (tile) ->
        if tile.selected
          $scope.tilesCount += 1
          $scope.tilesSum += tile.value

      if $scope.tilesSum == $scope.answerTotal.sum && $scope.tilesCount == $scope.answerTotal.count
        $scope.correctTiles = true
      else
        $scope.correctTiles = false



    return

