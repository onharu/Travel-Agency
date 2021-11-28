const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
//const { Server } = require("socket.io");
const io = require("socket.io")(server, {
    cors: {
      origin: "http://localhost:3000",
    },
    
  });

/*
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/index.html');
});

app.get('/alice', (req, res) => {
  res.sendFile(__dirname + '/index_alice.html');
});

app.get('/bob', (req, res) => {
  res.sendFile(__dirname + '/index_bob.html');
});

app.get('/carol', (req, res) => {
  res.sendFile(__dirname + '/index_carol.html');
});
*/
let users = {"alice":null, "bob":null, "carol":null};

io.use((socket, next) => {
  const username = socket.handshake.auth.username;
  if (!username) {
    return next(new Error("invalid username"));
  }
  socket.username = username; // alice, bob, carol のどれか
  users[username] = socket.id;
  next();
});

let pending = [];

io.on('connection', (socket) => {

    socket.on('message from browser', (param) => {
      console.log("join"+socket.username)
      console.log("メッセージがきた:"+JSON.stringify(param));
      let doit = () => {
        const to_userid = users[param.to_username];
        const msg = {from_username:socket.username, content:param.content};
        console.log(JSON.stringify(socket.username)+"がこのメッセージを"+JSON.stringify(param.to_username)+"におくる:"+JSON.stringify(msg));
        io.to(to_userid).emit('message from server', msg);
        //console.log(msg)
      }

      // もし users に alice, bob, carol が全部入っていたら・・・・　
      if (users["alice"]!=null && users["bob"]!=null && users["carol"]!=null) {
        // pending に入っている関数をすべて実行
        for (const f of pending){
          f()
        }
        pending = [];
        doit();
      } else {
        // やること
        pending.push(doit);
      }
    });
  });

server.listen(3050, () => {
  console.log('listening on *:3050');
});