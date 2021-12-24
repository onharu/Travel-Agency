open Mpst
@react.component
let make = () => {
    let myURL = ("http://localhost:3050");
    let onclick = (_e) => {
        let ch = Mpst.connect(Protocol.g, Protocol.customer, myURL)
        let ch = send(ch, x => #Service(x), x => #price(x), "1000")
        receive(ch, x => #Agency(x))
        -> Promise.thenResolve((#response(v, ch)) => {
            Js.Console.log(`agency: I got: ${v}`)
            close(ch)
        }) -> ignore
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

