angular.module 'App'
  .controller 'LoginController', ($rootScope, $scope, LoginService) ->
    'ngInject'

    $scope.loginUser = ->
      LoginService.login($scope.email, $scope.password)

    return
