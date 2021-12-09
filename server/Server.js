const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const io = require("socket.io")(server, {
    cors: {
      origin: "http://localhost:3000",
    },
  });

let users = {"customer":null, "service":null, "agency":null};

io.use((socket, next) => {
  const username = socket.handshake.auth.username;
  console.log("user:"+username)
  if (!username) {
    return next(new Error("invalid username"));
  }
  socket.username = username; // customer, service, agency のどれか
  users[username] = socket.id;
  next();
});

let pending = [];

io.on('connection', (socket) => {

    socket.on('message from browser', (msg0) => {
      console.log("join:"+socket.username)
      console.log("メッセージがきた:"+JSON.stringify(msg0));
      let doit = () => {
        const to_userid = users[msg0.to_username];
        const msg = {from_username:socket.username, content:msg0.content};
        console.log(JSON.stringify(socket.username)+"がこのメッセージを"+JSON.stringify(msg0.to_username)+"におくる:"+JSON.stringify(msg));
        io.to(to_userid).emit('message from server', msg);
        //console.log(msg)
      }
      pending.push(doit);
      // もし users に customer, service, agency が全部入っていたら・・・・　
      if (users["customer"]!=null && users["service"]!=null && users["agency"]!=null) {
        // pending に入っている関数をすべて実行
        for (const f of pending){
          f()
        }
        pending = [];
      }
    });
  });
server.listen(3050, () => {
  console.log('listening on *:3050');
});