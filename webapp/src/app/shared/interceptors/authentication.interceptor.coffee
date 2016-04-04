angular.module 'App'
  .factory 'AuthenticationInterceptor', ($q, $window) ->
    'ngInject'

    responseError: (response) ->
      if response.status == 401
        $window.location.assign('#/login')

      return $q.reject(response)
