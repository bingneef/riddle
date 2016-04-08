angular.module 'App'
  .controller 'LoginController', ($rootScope, $scope, $auth, $location, LoginService, SocketService) ->
    'ngInject'

    console.log 'here'

    $scope.googleOAuth = ->
      $auth.authenticate('google').then( (data) ->
        console.log data
      ).catch( (data) ->
        console.log data
      )


    $scope.loginUser = ->
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
