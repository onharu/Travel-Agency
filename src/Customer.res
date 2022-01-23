open Mpst
@react.component
let make = () => {
    let myURL = ("http://localhost:3050");
    let onclick = (_e) => {
        let ch_promise = Mpst.connect(Protocol.g, Protocol.customer, "travel_agency", ["Customer", "Agency", "Hotel"], myURL)//promiseに包まれたsession
        ch_promise -> Promise.thenResolve((ch) => {
            Js.Console.log("customer sends")
            let ch = send(ch, x => #Agency(x), x => #reserve(x), "aaa")
            receive(ch, x => #Hotel(x))
            -> Promise.thenResolve((#billing(_v, ch)) => {
                //Js.Console.log(`agency: I got: ${v}`)
                close(ch)
            }) -> ignore
            //Js_console.log("msg2")
        }) -> ignore
    }
    <button onClick={onclick}>{React.string("customer")}</button>
}

let default = make

/*
let onclick = (_e) => {
        let ch = Mpst.connect(Protocol.g, Protocol.customer, myURL)
        let ch = send(ch, x => #Hotel(x), x => #price(x), "1000")
        receive(ch, x => #Agency(x))
        -> Promise.thenResolve((#response(v, ch)) => {
            Js.Console.log(`agency: I got: ${v}`)
            close(ch)
        }) -> ignore
        Js_console.log("msg2")
    }
*/