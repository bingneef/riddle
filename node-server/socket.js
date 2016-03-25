module.exports = {
  socket: null,
  io: null,
  setupSockets: function(io) {
    this.io = io;
    io.on('connection',function(socket){
      var socketId = socket.id;

      socket.on('subscribe', function(room) {
        socket.join(room);
        io.sockets.in(room).emit('joined');
      })

      socket.on('unsubscribe', function(room) {
        socket.leave(room);
        io.sockets.in(room).emit('opponentDisconnected')
      })

      socket.on('slaveTransmit', function(data) {
        socket.broadcast.to(data.room).emit('slaveIncoming', data);
      });

      socket.on('masterTransmit', function(data) {
        socket.broadcast.to(data.room).emit('masterIncoming', data);
      });

      console.log("A user is connected");

      socket.on('disconnect', function(){
        console.log('user disconnected');
      });
    });
  }
}
