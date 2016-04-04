angular.module 'App'
  .factory 'LoginService', ($http, $state, Resources, localStorageService, SocketService) ->
    'ngInject'

    login: (email, password) ->
      Resources.authenticate {"email": email, "password": password}, (data) ->
        $http.defaults.headers.common["Authorization"] = "Token token=#{data.auth_token}"
        localStorageService.set('auth_token', data.auth_token)
        SocketService.initiate(data.auth_token)
        $state.go('app.dashboard')


    authenticate: ->
      token = localStorageService.get('auth_token')
      $http.defaults.headers.common["Authorization"] = "Token token=#{token}"
      Resources.getAuth()
      SocketService.initiate(token)

    logout: ->
      localStorageService.remove('auth_token')
      Resources.logout (data) ->
        $state.go('fs.login')


