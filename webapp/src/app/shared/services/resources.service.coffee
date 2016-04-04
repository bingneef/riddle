angular.module 'App'
  .factory 'Resources', ($resource, serverUrl) ->
    'ngInject'

    base_url = "#{serverUrl}api/v1"
    $resource base_url, { format: 'json' },

      'getAuth':
        method: 'GET'
        url: base_url + "/auth"

      'authenticate':
        method: 'POST'
        url: base_url + "/auth"

      'logout':
        method: 'POST'
        url: base_url + "/logout"
