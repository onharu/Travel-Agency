%%raw(`
//import React, {useState} from 'react';
import { io } from "socket.io-client";

function Service() {
    const URL = "http://localhost:3050";
    const socket = io(URL, { autoConnect: false });
    const onclick = () => {
        socket.auth = { username:"service" };
        socket.connect();
        socket.emit("message from browser", {to_username:"agency", content:"hello"});
        socket.on("message from server", (params) => {
            console.log("got a message from"+params.from_username+", content:"+params.content);
            
        //console.log("goodbye")
        //ここにsocket.ioを利用してコードを書く
    });
    }
    return (
        <button onClick={onclick}>service</button>
    );
    
}

export default Service;
`)