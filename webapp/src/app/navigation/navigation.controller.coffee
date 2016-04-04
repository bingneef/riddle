angular.module 'App'
  .controller 'NavigationController', ($scope, $state, $timeout, localStorageService, LoginService, Resources) ->
    'ngInject'

    $scope.logoutUser = ->
      LoginService.logout()

    $scope.navigateTo = (navigationTarget) ->
      $state.go('app.' + navigationTarget)
      $timeout(->
        $scope.$apply()
      , 0)


    return
