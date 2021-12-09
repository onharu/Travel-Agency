open WebSocket

open Mpst

type role_tag = RawTypes.polyvar_tag

type label_tag = RawTypes.polyvar_tag

type payload

type mpst_msg = (label_tag, payload)

type mpchan = WebSocket.socket


external payload_cast: 'v => payload = "%identity"
external payload_uncast: payload => 'v = "%identity"

let imai = {"name":"Keigo Imai", "address":"Nagoya"}

//let () = console.log(imai["name"])
//let () = console.log(imai.name) // JS なら

let raw_send: 'v. (mpchan, role_tag, label_tag, 'v) => unit = (mpchan, role, label, v) => {
  let msg = {"to_username":"username", "content":"hello"} 
  mpchan -> emit("message from browser", msg)
  //ch->MessagePort.postMessage((label, payload_cast(v)))
}

let raw_receive: 'v. (mpchan, ~from: role_tag) => Promise.t<(label_tag, 'v)> = (
  mpchan,
  ~from as role,
) => {
  Promise.make((resolve, _reject) => {
  let message = (params) => {
            Js_console.log("got a message from"++params.from_username++", content:"++params.content)
        }
  mpchan -> on("message from server", message)
  resolve(. (label, payload_uncast(payload)))
  })
}
