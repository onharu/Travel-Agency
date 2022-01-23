open Mpst

@react.component
let make = () => {
    let myURL = ("http://localhost:3050");
    let onclick = (_e) => {
        let ch_promise = Mpst.connect(Protocol.g, Protocol.agency,"travel_agency", ["Customer", "Agency", "Hotel"], myURL)
        ch_promise -> Promise.thenResolve((ch) => {
            receive(ch, x => #Customer(x)) -> Promise.thenResolve(ret => {
            let ch = switch ret {
                | (#reserve(_v, ch)) => send(ch, x => #Hotel(x), x => #price(x), "100")
                | (#cancel(_v, ch)) => send(ch, x => #Hotel(x), x => #quote(x), "no")
            }
            close(ch)
            }) -> ignore
            Js_console.log("msg2")
        }) -> ignore
    }
    <button onClick={onclick}>{React.string("agency")}</button>
}

let default = make


/*
let onclick = (_e) => {
        let ch = Mpst.connect(Protocol.g, Protocol.agency, myURL)
        receive(ch, x => #Hotel(x))
        -> Promise.thenResolve((#customer_option(v, ch)) => {
            Js.Console.log(`agency: I got: ${v}`)
            send(ch, x => #Customer(x), x => #response(x), "billing")
        }) -> ignore
        Js_console.log("msg2")
    }
*/