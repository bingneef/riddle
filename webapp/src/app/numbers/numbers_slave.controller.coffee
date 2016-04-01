angular.module 'App'
  .controller 'NumbersSlaveController', ($rootScope, $scope, $state, $window, $timeout, $interval, SocketService, SweetAlert) ->
    'ngInject'

    $scope.status = {}
    activeLevel = 'numbers'

    $scope.tiles = [
      {
        key: 10
        value: 1
        letter: 'S'
      }
      {
        key: 11
        value: 1
        letter: 'K'
      }
      {
        key: 15
        value: 2
        letter: 'A'
      }
      {
        key: 14
        value: 3
        letter: 'I'
      }
      {
        key: 13
        value: 5
        letter: 'O'
      }
      {
        key: 9
        value: 8
        letter: 'E'
      }
      {
        key: 5
        value: 13
        letter: 'T'
      }
      {
        key: 6
        value: 21
        letter: 'I'
      }
      {
        key: 7
        value: 34
        letter: 'E'
      }
      {
        key: 8
        value: 55
        letter: 'O'
      }
      {
        key: 12
        value: 89
        letter: 'E'
      }
      {
        key: 16
        value: 144
        letter: 'U'
      }
      {
        key: 20
        value: 233
        letter: 'O'
      }
      {
        key: 19
        value: 377
        letter: 'Y'
      }
      {
        key: 18
        value: 610
        letter: 'U'
      }
      {
        key: 17
        value: 987
        letter: 'V'
      }
      {
        key: 1
        value: 1597
        letter: 'A'
      }
      {
        key: 2
        value: 2584
        letter: 'L'
      }
      {
        key: 3
        value: 4181
        letter: 'B'
      }
      {
        key: 4
        value: 6765
        letter: 'R'
      }
      {
        key: 24
        value: 10946
        letter: 'U'
      }
      {
        key: 23
        value: 17711
        letter: 'I'
      }
      {
        key: 22
        value: 28657
        letter: 'L'
      }
      {
        key: 21
        value: 46368
        letter: 'A'
      }
    ]


    $rootScope.$on('masterIncoming', (event, data) ->
      if data.kind == 'level'
        $state.go('slave.' + data.value)
        return

      return unless data.level == activeLevel

      switch data.kind
        when 'status'
          paintBackground(data.value)
    )

    $scope.tileClick = (tile) ->
      tile.selected = !tile.selected
      SocketService.slaveTransmit({level: activeLevel, kind: 'tileStatus', tiles: $scope.tiles})
    return
