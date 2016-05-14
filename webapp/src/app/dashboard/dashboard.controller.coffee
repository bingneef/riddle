angular.module 'App'
  .controller 'DashboardController', ($rootScope, $location, $scope, $state, $timeout, SocketService) ->
    'ngInject'

    $scope.riddles = [
      {
        url: 'numbers'
        title: 'Numbers&Letters'
        subtitle: "Numbers and letters. That's It."
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In consectetur posuere dolor sed pharetra. Mauris nec iaculis lectus, non ullamcorper magna."
        date: "11:09 PM - 1 Jan 2015"
        liked: true

      }
      {
        url: 'compass'
        title: 'Compass'
        subtitle: "Where to go?"
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In consectetur posuere dolor sed pharetra. Mauris nec iaculis lectus, non ullamcorper magna."
        date: "11:09 PM - 1 Jan 2016"
        liked: false
      }
      {
        url: 'duckhunt'
        title: 'Duckhunt'
        subtitle: "5-7-5"
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In consectetur posuere dolor sed pharetra. Mauris nec iaculis lectus, non ullamcorper magna."
        date: "11:09 PM - 10 Jan 2016"
        liked: false
      }
    ]

    $scope.gotoRiddle = (riddle) ->
      $state.go("app.#{riddle.url}")

    $scope.$on 'socketTransmit', (evt, data) ->
      console.log evt, data

    activeLevel = 'dashboard'
    payload = {
      destination: 'slave'
      level: activeLevel
    }

    SocketService.socketTransmit(payload)

    return
