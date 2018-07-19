const express = require('express');
const app = express();
const expressWS = require('express-ws')(app);

const port = 3001

app.ws('/hello', function(websocket, request) {
  console.log('A client connected!');

  websocket.on('message', function(message) {
    console.log(`A client sent a message: ${message}`);
    websocket.send(message);
  });
});

app.listen(port, function() {
  console.log(`Listening on port ${port}`);
});
