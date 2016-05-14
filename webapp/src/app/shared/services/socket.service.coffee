angular.module 'App'
  .service 'SocketService', ($rootScope, socketUrl) ->
    'ngInject'

    socket: io.connect(socketUrl)
    initiate: (room) ->
      console.log room
      this.socket.on('socketTransmit', (data) ->
        if angular.equals(data.destination, $rootScope.socketRole)
          $rootScope.$broadcast 'socketTransmit', data
      )
      this.unsubscribe(room)
      this.subscribe(room)
    subscribe: (data) ->
      this.room = data.room
      this.socket.emit('subscribe', this.room)
    unsubscribe: (room) ->
      this.room = room
      this.socket.emit('unsubscribe', room)
    slaveTransmit: (data) ->
      data.room = this.room
      this.socket.emit('slaveTransmit', data)
    masterTransmit: (data) ->
      data.room = this.room
      this.socket.emit('masterTransmit', data)
    socketTransmit: (data) ->
      data.room = this.room
      data.host = $rootScope.socketRole
      console.log 'transmit', data
      this.socket.emit('socketTransmit', data)
