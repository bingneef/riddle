angular.module 'App'
  .controller 'Oauth2Controller', ($location, LoginService) ->
    'ngInject'

    if $location.search().callback == 'true'
      LoginService.persistAuthToken($location.search().auth_token)
    else
      $window.close()

    return
