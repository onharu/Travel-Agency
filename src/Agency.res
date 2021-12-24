open Mpst

@react.component
let make = () => {
    let myURL = ("http://localhost:3050");
    let onclick = (_e) => {
        let ch = Mpst.connect(Protocol.g, Protocol.agency, myURL)
        receive(ch, x => #Service(x))
        -> Promise.thenResolve((#customer_option(v, ch)) => {
            Js.Console.log(`agency: I got: ${v}`)
            send(ch, x => #Customer(x), x => #response(x), "billing")
        }) -> ignore
        //Js_console.log("msg")
        //socket["auth"] = { "username":"agency" }
        //socket -> connect
        //socket -> emit("message from browser", {"to_username":"customer", "content":"sorry"})
        //socket -> on("message from service"  , (params) => {
            //Js_console.log("got a message from: "++params.from_username++", content: "++params.content)
        //})
        Js_console.log("msg2")
    }
    <button onClick={onclick}>{React.string("agency")}</button>
}

let default = make