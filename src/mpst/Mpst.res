open WebSocket

type session<'a> = {dummy_witness: 'a, mpchan: RawTransport.mpchan}

// [`Bob; `Alice] : [> `Bob | `Alice] list
// 多相ヴァリアントのコンストラクタ. v => #Bob(v) : open_variant<#Bob('v), 'v>
type open_variant<'var, 'v> = 'v => 'var

// #Bob(v) => v
type closed_variant<'var, 'v> = {
  closed_match: 'var => 'v,
  closed_make: 'v => 'var,
}

type disj<'lr, 'l, 'r> = {
  concat: (list<'l>, list<'r>) => list<'lr>,
  split: list<'lr> => (list<'l>, list<'r>),
}

type global<'a, 'b, 'c> = (session<'a>, session<'b>, session<'c>)

type lens<'a, 'b, 's, 't> = {
  get: 's => session<'a>,
  put: ('s, session<'b>) => 't,
}

type role<'a, 'b, 's, 't, 'obj, 'v> = {//role...通信者の名前のようなもの
  role_label: closed_variant<'obj, 'v>,
  role_lens: lens<'a, 'b, 's, 't>,
}

type label<'obj, 't, 'var, 'u> = {
  label_closed: closed_variant<'obj, 't>,
  label_open: open_variant<'var, 'u>,
}

type out<'lab> = {__out_witness: 'lab}

type inp<'lab> = {__inp_witness: 'lab}

let list_match: ('a => 'b, list<'a>) => 'b = (_, _) => Raw.assertfalse()

let role_to_tag: role<_, _, _, _, _, _> => RawTypes.polyvar_tag = role => {
  let (roletag, _) = Raw.destruct_polyvar(role.role_label.closed_make(Raw.dontknow()))
  roletag
}

let open_variant_to_tag: 'var. open_variant<'var, _> => RawTypes.polyvar_tag = var => {
  let (roletag, _) = Raw.destruct_polyvar(var(Raw.dontknow()))
  roletag
}

let connect: (
  global<'a, 'b, 'c>,
  role<'t, _, global<'a, 'b, 'c>, _, _, _>,
  string,
  array<string>,
  string
) => Js.Promise.t<session<'t>> = (_g, role, protocolname, roles, url) => {
  Promise.make((resolve,_reject) => {
    let socket = io(. url, { "autoConnect": false })
    let (role_tag, _) = Raw.destruct_polyvar(role.role_label.closed_make(Raw.dontknow()))
    socket["auth"] = {"username": role_tag , "protocolname": protocolname, "rolenames": roles}
    socket -> connect
    socket -> on("participants", (_msg) => {
      Js.Console.log("recieve")
      resolve(. {mpchan: socket, dummy_witness: Raw.dontknow()})
    })
  });
}

let send: 'var 'lab 'v 'c. (
  session<'var>,
  open_variant<'var, out<'lab>>,
  open_variant<'lab, ('v, session<'c>)>,
  'v,
) => session<'c> = (sess, role, label, v) => {
  let roletag = open_variant_to_tag(role)
  let labeltag = open_variant_to_tag(label)
  RawTransport.raw_send(sess.mpchan, roletag, labeltag, v)
  {mpchan: sess.mpchan, dummy_witness: Raw.dontknow()}  
}

let receive: 'var 'lab. (
  session<'var>, 
  open_variant<'var, inp<'lab>>
) => Js.Promise.t<'lab> = (sess, role) => {
  let roletag = open_variant_to_tag(role)
  RawTransport.raw_receive(sess.mpchan, roletag)->Promise.thenResolve(((labeltag, val)) => {
    let cont = {mpchan: sess.mpchan, dummy_witness: Raw.dontknow()}
    Raw.make_polyvar(labeltag, (val, cont))
  })
}

let close: session<unit> => unit = _ => ()

let \"-->": 'from 'to_ 'outlab 'inplab 's 't 'v 'next 'mid 'cur. (
  role<'s, 'to_, 'mid, 'cur, 'from, inp<'inplab>>,
  role<'t, 'from, 'next, 'mid, 'to_, out<'outlab>>,
  label<'outlab, ('v, session<'s>), 'inplab, ('v, session<'t>)>,
  'next,
) => 'cur = (_from, _to, _label, _next) => Raw.dontknow()

let finish: global<unit, unit, unit> = Raw.dontknow()

let choice_at: 'cur 'a 'b 'c 'left 'right 'lr 'l 'r 'x. (
  role<unit, 'lr, global<'a, 'b, 'c>, 'cur, 'x, _>,
  disj<'lr, 'l, 'r>,
  (role<'l, unit, 'left, global<'a, 'b, 'c>, 'x, _>, 'left),
  (role<'r, unit, 'right, global<'a, 'b, 'c>, 'x, _>, 'right),
) => 'cur = (_role, _disj, (_role1, _left), (_role2, _right)) => Raw.dontknow()

/*
let extract: 'a 'b 'c. (
  global<'a, 'b, 'c>,
  role<'t, _, global<'a, 'b, 'c>, _, _, _>,
) => session<'t> = (_g, _role) => Raw.todo()
*/
