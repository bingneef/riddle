angular.module 'App'
  .factory 'Resources', ($resource) ->
    'ngInject'

    base_url = 'http://localhost:9393/api/v1'
    $resource base_url, { format: 'json' },

      'getCallHistory':
        method: 'GET'
        url: base_url + "/users"

      'verifyToken':
        method: 'POST'
        url: base_url + "/verify"
