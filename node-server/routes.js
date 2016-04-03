var express = require('express');
var router = express.Router();
var socket = require('./socket.js');

/* GET home page. */
router.post('/transmit', function(req, res, next) {
  socket.transmit(data);
  res.statusCode = 200;
  res.send('ok');
});


module.exports = router;
