angular.module 'App'
  .factory 'Resources', ($resource, serverUrl) ->
    'ngInject'

    base_url = "#{serverUrl}api/v1"
    $resource base_url, { format: 'json' },

      'login':
        method: 'POST'
        url: base_url + "/login"

      'authenticate':
        method: 'GET'
        url: base_url + "/auth"

      'logout':
        method: 'POST'
        url: base_url + "/logout"
