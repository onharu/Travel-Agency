// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as SocketIoClient from "socket.io-client";

function Agency(Props) {
  var socket = SocketIoClient.io("http://localhost:3050", {
        autoConnect: false
      });
  var onclick = function (_e) {
    console.log("msg");
    socket.auth = {
      username: "agency"
    };
    socket.connect();
    socket.emit("message from browser", {
          to_username: "customer",
          content: "hello"
        });
    socket.on("message from server", (function (params) {
            console.log("got a message from" + params.from_username + ", content:" + params.content);
            
          }));
    console.log("msg2");
    
  };
  return React.createElement("button", {
              onClick: onclick
            }, "agency");
}

var make = Agency;

var $$default = Agency;

export {
  make ,
  $$default ,
  $$default as default,
  
}
/* react Not a pure module */
