open Mpst

@react.component
let make = () => {
    let myURL = ("http://localhost:3050");
    let onclick = (_e) => {
        let ch_promise = Mpst.connect(Protocol.g, Protocol.hotel, "travel_agency", ["Customer", "Agency", "Hotel"], myURL)
        ch_promise -> Promise.thenResolve((ch) => {
            receive(ch, x => #Agency(x)) -> Promise.thenResolve(ret => {
            let ch = switch ret {
                | (#price(_v, ch)) => send(ch, x => #Customer(x), x => #billing(x), "bbb")
                | (#quote(_v, ch)) => ch
            }
            close(ch)
            }) -> ignore
            Js_console.log("msg2")
        }) ->ignore
    }
    <button onClick={onclick}>{React.string("hotel")}</button>
}

let default = make
