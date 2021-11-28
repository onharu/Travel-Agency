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

/*
let customer = () => {
    let URL = "http://localhost:3050"
    let socket = io(URL, { autoConnect: false })
    let onclick = () => {
        socket.auth = { username:"customer" }
        socket.connect();
        socket.emit("message from browser", {to_username:"service", content:"hello"})
        socket.on("message from server", (params) => {
            console.log("got a message from"+params.from_username+", content:"+params.content)
    })
    }
}
*/