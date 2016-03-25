angular.module 'App'
  .controller 'NavigationController', ($scope, $state, $timeout) ->
    'ngInject'

    $scope.navigateTo = (navigationTarget) ->
      $state.go('app.' + navigationTarget)
      $timeout(->
        $scope.$apply()
      , 0)

    return
