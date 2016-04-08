angular.module 'App'
  .factory 'LoginService', ($rootScope, $http, $state, $q, $window, Resources, localStorageService, SocketService) ->
    'ngInject'

    persistAuthToken: (authToken) ->
      $http.defaults.headers.common["Authorization"] = "Token token=#{authToken}"
      localStorageService.set('auth_token', authToken)
      SocketService.initiate(authToken)
      Resources.authenticate (data) ->
        console.log 'here'
        # $window.close()
        # $state.go('app.dashboard')

    login: (email, password) ->
      defer = $q.defer()
      Resources.login {"email": email, "password": password}, (data) ->
        this.persistAuthToken(data.auth_token)
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


