angular.module 'App'
  .controller 'NavigationController', ($scope, $state, $timeout, localStorageService, LoginService, Resources) ->
    'ngInject'

    $scope.overlay = false

    $scope.hideOverlay = ->
      $scope.overlay = false

    $scope.toggleOverlay = ->
      $scope.overlay = !$scope.overlay

    $scope.logoutUser = ->
      LoginService.logout()

    $scope.navigateTo = (navigationTarget) ->
      $state.go('app.' + navigationTarget)


    return
