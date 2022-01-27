open WebSocket

type role_tag = RawTypes.polyvar_tag
type label_tag = RawTypes.polyvar_tag
type payload
type mpchan = WebSocket.socket
//type mpst_msg = (label_tag, payload)
//type buffer

external payload_cast: 'v => payload = "%identity"
external payload_uncast: payload => 'v = "%identity"

let raw_send: 'v. (mpchan, role_tag, label_tag, 'v) => unit = 
(mpchan, role, label, v) => {
  let msg = {"to_username":role, "content":(label,v)} 
  mpchan -> emit("message from browser", msg)
}

let raw_receive: 'v. (mpchan, role_tag) => Promise.t<(label_tag, 'v)> = 
(mpchan, role) => {
  Promise.make((resolve, _reject) => {
    let message = (params) => {
      let content_message = params["content"]
      let (content_label, content_payload) = content_message
      resolve(. (content_label,content_payload))
    }
    mpchan -> on("message from " ++ role, message)
  })
}
