open Mpst
@react.component
let make = () => {
    let myURL = ("http://localhost:3050");
    let onclick = (_e) => {
        let ch_promise = Mpst.connect(Protocol.g, Protocol.agency,"travel_agency", ["Customer", "Agency", "Hotel"], myURL)
        ch_promise -> Promise.thenResolve((ch) => {
            receive(ch, x => #Customer(x)) -> Promise.thenResolve(ret => {
            let ch = switch ret {
                | (#reserve(_v, ch)) => send(ch, x => #Hotel(x), x => #price(x), "1000")
                | (#cancel(_v, ch)) => send(ch, x => #Hotel(x), x => #notice(x), "Customer canceled")
            }
            close(ch)
            }) -> ignore
        }) -> ignore
    }
    <button onClick={onclick}>{React.string("agency")}</button>
}
let default = make