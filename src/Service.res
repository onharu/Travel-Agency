open Mpst

@react.component
let make = () => {
    let myURL = ("http://localhost:3050");
    let onclick = (_e) => {
        let ch = Mpst.connect(Protocol.g, Protocol.service, myURL)
        //Js_console.log("msg")
        //socket -> emit("message from browser", {"to_username":"agency", "content":"customer_option"})
        receive(ch, x => #Customer(x))
        -> Promise.thenResolve((#price(v, ch)) => {
            Js.Console.log(`service: I got: ${v}`)
            send(ch, x => #Agency(x), x => #customer_option(x), "option")
        }) -> ignore
        //socket -> on("message from customer", (params) => {
          //  Js_console.log("got a message from: "++params.from_username++", content: "++params.content)
        //})
        Js_console.log("msg2")
    }
    <button onClick={onclick}>{React.string("service")}</button>
}

let default = make
