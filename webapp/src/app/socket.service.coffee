angular.module 'App'
  .service 'SocketService', ($rootScope, socketUrl) ->
    'ngInject'

    socket: io.connect(socketUrl)
    initiate: ->
      this.socket.on('slaveIncoming', (data) ->
        $rootScope.$broadcast('slaveIncoming', data)
      )
      this.socket.on('masterIncoming', (data) ->
        $rootScope.$broadcast('masterIncoming', data)
      )
      this.subscribe('abc')
    subscribe: (room) ->
      this.room = room
      this.socket.emit('subscribe', room)
    unsubscribe: (room) ->
      this.room = room
      this.socket.emit('unsubscribe', room)
    slaveTransmit: (data) ->
      data.room = this.room
      this.socket.emit('slaveTransmit', data)
    masterTransmit: (data) ->
      data.room = this.room
      this.socket.emit('masterTransmit', data)
