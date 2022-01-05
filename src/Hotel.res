open Mpst

@react.component
let make = () => {
    let myURL = ("http://localhost:3050");
    let onclick = (_e) => {
        let ch = Mpst.connect(Protocol.g, Protocol.hotel, myURL)
        //Js_console.log("msg")
        //socket -> emit("message from browser", {"to_username":"agency", "content":"customer_option"})
        receive(ch, x => #Agency(x)) -> Promise.thenResolve(ret => {
            let ch = switch ret {
                | (#price(_v, ch)) => send(ch, x => #Customer(x), x => #billing(x), "bbb")
                | (#quote(_v, ch)) => ch
        }
        close(ch)
        }) -> ignore
        //socket -> on("message from customer", (params) => {
          //  Js_console.log("got a message from: "++params.from_username++", content: "++params.content)
        //})
        Js_console.log("msg2")
    }
    <button onClick={onclick}>{React.string("hotel")}</button>
}

let default = make
