open WebSocket

@react.component
let make = () => {
    let myURL = ("http://localhost:3050");
    //localhost..自分のパソコンだけにつながる
    let socket = io(. myURL, { "autoConnect": false })
    let onclick = (_e) => {
        Js_console.log("msg")
        socket["auth"] = { "username":"service" }
        socket -> connect
        socket -> emit("message from browser", {"to_username":"agency", "content":"hello"})
        socket -> on("message from server", (params) => {
            Js_console.log("got a message from"++params.from_username++", content:"++params.content)
        })
        Js_console.log("msg2")
    }
    <button onClick={onclick}>{React.string("service")}</button>
}

let default = make
