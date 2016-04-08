angular.module 'App'
  .factory 'LoginService', ($rootScope, $http, $state, $q, Resources, localStorageService, SocketService) ->
    'ngInject'

    login: (email, password) ->
      defer = $q.defer()
      Resources.login {"email": email, "password": password}, (data) ->
        $http.defaults.headers.common["Authorization"] = "Token token=#{data.auth_token}"
        localStorageService.set('auth_token', data.auth_token)
        SocketService.initiate(data.auth_token)
        $rootScope.currentUser = data
        $state.go('app.dashboard')
        defer.resolve(data)
      , (data) ->
        defer.reject(data)

      return defer.promise


    authenticate: ->
      token = localStorageService.get('auth_token')
      $http.defaults.headers.common["Authorization"] = "Token token=#{token}"
      Resources.authenticate (data) ->
        $rootScope.currentUser = data
      SocketService.initiate({room: token, role: $rootScope.socketRole})

    logout: ->
      localStorageService.remove('auth_token')
      Resources.logout (data) ->
        $state.go('fs.login')


