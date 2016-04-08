angular.module 'App'
  .config ($logProvider, $httpProvider, localStorageServiceProvider, $authProvider) ->
    'ngInject'
    # Enable log
    $logProvider.debugEnabled true
    # Set options third-party lib
    $httpProvider.interceptors.push('AuthenticationInterceptor')
    localStorageServiceProvider.setPrefix('Riddle')

    $authProvider.google({
      clientId: '461046162325-039to168l5t08rbj3c58e5k3o5u5j982.apps.googleusercontent.com',
      redirectUri: 'http://localhost:5000/api/v1/login'
      requiredUrlParams: ['scope'],
      scope: ['profile', 'email'],
    })



