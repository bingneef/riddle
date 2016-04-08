angular.module 'App'
  .controller 'LoginController', ($rootScope, $scope, $auth, LoginService) ->
    'ngInject'

    $scope.loginUser = ->
      console.log 'here'
      $auth.authenticate('google')
      return

      $scope.loggingIn = true
      LoginService.login($scope.email.trim().toLowerCase(), $scope.password).then (data) ->
        console.log data
        $scope.loggingIn = false
      , (data) ->
        if data.status = 401
          $scope.message = 'Wrong password'
        else
          $scope.message = 'Email not found'
        $scope.loggingIn = false

    return
