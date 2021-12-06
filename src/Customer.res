open WebSocket
@react.component
let make = () => {
    //let io = %raw(`require("socket.io-client")`)
    let myURL = createURL("http://localhost:3050");
    let socket = io(. myURL, { "autoConnect": false })
    let onclick = (_event) => {
        Js_console.log("msg")
        socket["auth"] = { "username":"customer" }
        socket -> connect
        socket -> emit("message from browser", {"to_username":"service", "content":"hello"})
        socket -> on("message from server", (params) => {
            Js_console.log("got a message from"++params.from_username++", content:"++params.content)
        })
        Js_console.log("msg2")
    }
    <button onClick={onclick}>{React.string("customer")}</button>
}

let default = make

/*
%%raw(`
//import React, {useState} from 'react';
import { io } from "socket.io-client";

function Customer() {
    const URL = "http://localhost:3050";
    const socket = io(URL, { autoConnect: false });
    const onclick = () => {
        socket.auth = { username:"customer" };
        socket.connect();
        socket.emit("message from browser", {to_username:"service", content:"hello"});
        socket.on("message from server", (params) => {
            console.log("got a message from"+params.from_username+", content:"+params.content);
            
        //console.log("hello")
        //ここにsocket.ioを利用してコードを書く
    });
    }
    return (
        <button onClick={onclick}>customer</button>
    );
    
}

export default Customer;

`)
*/

