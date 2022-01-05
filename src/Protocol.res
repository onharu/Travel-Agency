open Mpst

let lens_c = {
  get: ((_, _, c)) => c,
  put: ((a, s, _), c) => (a, s, c),
}

let lens_s = {
  get: ((_, s, _)) => s,
  put: ((a, _, c), s) => (a, s, c),
}

let lens_a = {
  get: ((a, _, _)) => a,
  put: ((_, s, c), a) => (a, s, c),
}


let customer = {
  role_label: {closed_match: (#Customer(v)) => v, closed_make: v => #Customer(v)},
  role_lens: lens_c,
}

let service = {
  role_label: {closed_match: (#Service(v)) => v, closed_make: v => #Service(v)},
  role_lens: lens_s,
}

let agency = {
  role_label: {closed_match: (#Agency(v)) => v, closed_make: v => #Agency(v)},
  role_lens: lens_a,
}

let reserve_or_cancel = {
  split: lr => (list{#reserve(list_match(x =>
          switch x {
          | #reserve(v) => v
          | #cancel(_) => Raw.dontknow()
          }
        , lr))}, list{#cancel(list_match(x =>
          switch x {
          | #cancel(v) => v
          | #reserve(_) => Raw.dontknow()
          }
        , lr))}),
  concat: (l, r) => list{
    #reserve(list_match((#reserve(v)) => v, l)),
    #cancel(list_match((#cancel(v)) => v, r)),
  },
}

let price = {
  label_closed: {closed_match: (#price(v)) => v, closed_make: v => #price(v)},
  label_open: v => #price(v),
}

let customer_option = {
  label_closed: {closed_match: (#customer_option(v)) => v, closed_make: v => #customer_option(v)},
  label_open: v => #customer_option(v),
}

let response = {
  label_closed: {closed_match: (#response(v)) => v, closed_make: v => #response(v)},
  label_open: v => #response(v),
}

let g = \"-->"(customer, service, price, \"-->"(service, agency, customer_option, \"-->"(agency, customer, response, finish)))



/*
let hello = {
  label_closed: {closed_match: (#hello(v)) => v, closed_make: v => #hello(v)},
  label_open: v => #hello(v),
}

let goodbye = {
  label_closed: {closed_match: (#goodbye(v)) => v, closed_make: v => #goodbye(v)},
  label_open: v => #goodbye(v),
}

let hello_or_goodbye = {
  split: lr => (list{#hello(list_match(x =>
          switch x {
          | #hello(v) => v
          | #goodbye(_) => RescriptMpst.Raw.dontknow()
          }
        , lr))}, list{#goodbye(list_match(x =>
          switch x {
          | #goodbye(v) => v
          | #hello(_) => RescriptMpst.Raw.dontknow()
          }
        , lr))}),
  concat: (l, r) => list{
    #hello(list_match((#hello(v)) => v, l)),
    #goodbye(list_match((#goodbye(v)) => v, r)),
  },
}

// let to_bob = disj => {
//   concat: (l, r) =>
//     List.map(
//       v => #Bob({__out_witness: v}),
//       disj.concat(
//         List.map((#Bob(v)) => v.__out_witness, l),
//         List.map((#Bob(v)) => v.__out_witness, r),
//       ),
//     ),
//   split: lr => {
//     let (l, r) = disj.split(List.map((#Bob(v)) => v.__out_witness, lr))
//     (List.map(v => #Bob({__out_witness: v}), l), List.map(v => #Bob({__out_witness: v}), r))
//   },
// }

*/

//let g = \"-->"(alice, bob, hello, \"-->"(bob, alice, goodbye, finish))
//let g = fix(t = \"-->"(alice, bob, hello, \"-->"(bob, alice, goodbye, t)))
// fix ....roop