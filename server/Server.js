const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);
const io = require("socket.io")(server, {
    cors: {
      origin: "http://localhost:3000"//ポート番号3000版のみ許可
    }
  });
const protocols = {};
//protocols は　{"travel_agency"というフィールドを持つオブジェクトで、フィールドの中身は{"Customer": ..., "Agency":..., "Hotel":...}となっている
//protocols = {"travel_agency":{"Customer": ..., "Agency":..., "Hotel":...}}

console.log("start")

io.on('connection', (socket) => {
  const username = socket.handshake.auth.username;//serverに接続してきたユーザーの名前
  const protocolname = socket.handshake.auth.protocolname;//authのprotocolnameを取得
  const rolenames = socket.handshake.auth.rolenames;//authのrolenamesを取得
  console.log("user:"+username);
  //auth:{"username":string, "protocolname":string, "rolenames":array<string>}
  //authはstring型のキーを持つusernameと、string型のキーを持つprotocolnameと、string型の配列をキーに持つrolenameの、３要素の連想配列
  
  if(protocols[protocolname] === undefined){//protocolsが定義されていないとき(接続しにきた人のプロトコル名がないとき)
    protocols[protocolname] = {};//新たにプロトコル名を追加する
    //tra2は元々あり、新たにtra1が追加されたとき
    //protocols = {"tra1":{}, "tra2":{"A":[], "B":[], "C":[]}}
    for (const p of rolenames){//rolenameの配列内にある要素に対して以下を実行
      protocols[protocolname][p] = [];//プロトコルに要素を追加していく
      //"tra1":{} -> "tra1":{"A":[], ....}
    }
    console.log("add protocolname");
  }
  //console.log(protocols);
  //else（プロトコル名が既にある場合)
  //if (!username) {
  //   return next(new Error("invalid username"));
  //}
  //socket.username = username; // customer, agency, hotel のどれか
  socket.username = username;
  protocols[protocolname][username].push(socket);//接続しにきた人の値にsocket(idなど)を代入
  console.log(protocols);
  let judgment = true;
  for(const role of rolenames){
    if (protocols[protocolname][role].length === 0){
    //protocolname内の要素の値が、空の配列の場合
    //protocol{"tra1":{"A":a's id, "B":b's id, "C":[]}}
      judgment = false;//jにfalseを代入
    }
  }

  if(judgment){
    //protocolsの各protocolnameに存在する参加者のsocketの情報を取り出す
    let hole = {};
    for(const role of rolenames){
      //hole = hole + [protocols[protocolname][role2].shift()];//各参加者の先頭のsocket情報(imutable)
      //hole.push(protocols[protocolname][role2].shift());//(mutable)
      hole[role] = protocols[protocolname][role].shift();
    }
    
    //プロトコルの参加者が全員揃ったことを各参加者に伝える。この知らせを受け次第、参加者からのメッセージを受け取る。
    for(const role of rolenames){
      console.log("c");
      let socket_id = hole[role].id;
      io.to(socket_id).emit('participants', "");
    }
    
    for(const role of rolenames){
      let socket = hole[role];//hole = {"A": [], "B": [],} ==> [] -> [socket]
      console.log(socket.id);
      socket.on('message from browser', (msg) => {
        //ユーザーから'message from browser'というイベントを受け取ったら、(msg)を受け取って以下を実行
        //msg = {"to_username":role, "content":(label,v)}
        //例えば msg = {"Customer", "aaa"}
        console.log("join:"+socket.username);
        console.log("メッセージがきた:"+JSON.stringify(msg)); 
        //const protocolname = socket.handshake.auth.protocolname;
        const to_userid = hole[msg.to_username].id;//pro;A->B  protocols{"tra":{"A":A_socket, "B":B_socket,.....}} --> to_userid = A_socket
        const msg2 = {from_username:socket.username, content:msg.content};
        //差出人とメッセージの内容の連想配列 ex; msg2 = {from_username: Customer, content:"aaa"} 
        console.log(JSON.stringify(socket.username)+"がこのメッセージを"+JSON.stringify(msg.to_username)+"におくる:"+JSON.stringify(msg2));
        io.to(to_userid).emit('message from ' + socket.username, msg2);
        //宛先にイベント名と内容を送る
        //ex; io.to(Agency).emit('message from ' + Customer, {Customer, "aaa"})
        console.log(msg2)
        //const rolenames = socket.handshake.auth.rolenames;
      });
    }
  }
    //protocol{"tra1":{"A":a's id, "B":b's id, "C":c's id}, "tra2":{"D":d's id, "E":e's id, "F":f's id}}
    //--> hole = [a's id, b's id, c's id, d's id, e's id, f's id]
  //next();  
});

//io.on('connection', (socket) => {//'connection'というイベントが来たら、socketを引数にとって動作する
  //});

  
server.listen(3050, () => {
  console.log('listening on *:3050');
});

