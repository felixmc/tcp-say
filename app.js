'use strict';

const net = require('net');

const PORT = process.env.PORT || 8124;

const nextId     = Date.now;
const showPrompt = process.stdout.write.bind(process.stdout, 'say> ');

const clients = {};


let server = net.createServer(client => {
  const cId = nextId();
  clients[cId] = client;

  client.on('end', _ => { delete clients[cId]; });
});

server.listen(PORT, function() {
  console.log('server bound to port', PORT);
  showPrompt();
});

process.stdin.on('data', function(text) {
  Object.keys(clients).forEach(cId => clients[cId].write(text));
  showPrompt();
});
