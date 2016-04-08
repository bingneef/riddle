angular.module 'App'
  .factory 'AuthenticationInterceptor', ($q, $window, $location) ->
    'ngInject'

    responseError: (response) ->
      if response.status == 401
        unless $location.$$path.indexOf('/login') == 0
          $window.location.assign('#/login')

      return $q.reject(response)
