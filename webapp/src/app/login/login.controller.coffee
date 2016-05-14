angular.module 'App'
  .controller 'LoginController', ($rootScope, $scope, $auth, $location, $state, LoginService, SocketService, localStorageService, $interval) ->
    'ngInject'

    $scope.googleOAuth = ->
      localStorageService.remove('auth_token_state')
      $auth.authenticate('google')
      interval = $interval ->
        if localStorageService.get('auth_token_state') == 'success'
          localStorageService.remove('auth_token_state')
          $state.go 'app.dashboard'
        if localStorageService.get('auth_token_state') == 'failed'
          localStorageService.remove('auth_token_state')
          interval = null
      , 10

    $scope.facebookOAuth = ->
      localStorageService.remove('auth_token_state')
      $auth.authenticate('facebook').then (data) ->
        console.log 'good', data
      interval = $interval ->
        if localStorageService.get('auth_token_state') == 'success'
          localStorageService.remove('auth_token_state')
          $state.go 'app.dashboard'
        if localStorageService.get('auth_token_state') == 'failed'
          localStorageService.remove('auth_token_state')
          interval = null
          console.log 'error'
      , 10

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
