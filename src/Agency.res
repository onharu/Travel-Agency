open WebSocket
@react.component
let make = () => {
    let myURL = ("http://localhost:3050");
    let socket = io(. myURL, { "autoConnect": false })
    let onclick = (_e) => {
        Js_console.log("msg")
        socket["auth"] = { "username":"agency" }
        socket -> connect
        socket -> emit("message from browser", {"to_username":"customer", "content":"hello"})
        socket -> on("message from server", (params) => {
            Js_console.log("got a message from"++params.from_username++", content:"++params.content)
        })
        Js_console.log("msg2")
    }
    <button onClick={onclick}>{React.string("agency")}</button>
}

let default = make