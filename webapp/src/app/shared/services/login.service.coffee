angular.module 'App'
  .factory 'LoginService', ($rootScope, $http, $state, $q, $window, $location, Resources, localStorageService, SocketService) ->
    'ngInject'

    persistAuthToken: (authToken) ->
      $http.defaults.headers.common["Authorization"] = "Token token=#{authToken}"
      Resources.authenticate (data) ->
        localStorageService.set('auth_token_state', 'success')
        localStorageService.set('auth_token', authToken)
        $window.close()
      , (data) ->
        localStorageService.set('auth_token_state', 'failed')
        $window.close()

    login: (email, password) ->
      defer = $q.defer()
      Resources.login {"email": email, "password": password}, (data) ->
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
        $state.go('app.dashboard') if $location.$$path.indexOf('/login') == 0
      , (data) ->
        console.log 'not authorized'

    logout: ->
      Resources.logout (data) ->
        localStorageService.remove('auth_token')
        $state.go('fs.login')


