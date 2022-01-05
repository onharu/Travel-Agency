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

let hotel = {
  role_label: {closed_match: (#Hotel(v)) => v, closed_make: v => #Hotel(v)},
  role_lens: lens_s,
}

let agency = {
  role_label: {closed_match: (#Agency(v)) => v, closed_make: v => #Agency(v)},
  role_lens: lens_a,
}

let reserve = {
  label_closed: {closed_match: (#reserve(v)) => v, closed_make: v => #reserve(v)},
  label_open: v => #reserve(v),
}

let cancel = {
  label_closed: {closed_match: (#cancel(v)) => v, closed_make: v => #cancel(v)},
  label_open: v => #cancel(v),
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

let billing = {
  label_closed: {closed_match: (#billing(v)) => v, closed_make: v => #billing(v)},
  label_open: v => #billing(v),
}

let customer_option = {
  label_closed: {closed_match: (#customer_option(v)) => v, closed_make: v => #customer_option(v)},
  label_open: v => #customer_option(v),
}

let response = {
  label_closed: {closed_match: (#response(v)) => v, closed_make: v => #response(v)},
  label_open: v => #response(v),
}

let quote = {
  label_closed: {closed_match: (#quote(v)) => v, closed_make: v => #quote(v)},
  label_open: v => #quote(v),
}

let to_agency = disj => {
   concat: (l, r) =>
     List.map(
       v => #Agency({__out_witness: v}),
       disj.concat(
         List.map((#Agency(v)) => v.__out_witness, l),
         List.map((#Agency(v)) => v.__out_witness, r),
       ),
     ),
   split: lr => {
     let (l, r) = disj.split(List.map((#Agency(v)) => v.__out_witness, lr))
     (List.map(v => #Agency({__out_witness: v}), l), List.map(v => #Agency({__out_witness: v}), r))
   },
}

//let g = \"-->"(customer, hotel, price, \"-->"(hotel, agency, customer_option, \"-->"(agency, customer, response, finish)))
let g = choice_at(
  customer,
  to_agency(reserve_or_cancel),
  (
    customer,
    \"-->"(customer, agency)(reserve, \"-->"(agency,hotel)(price, \"-->"(hotel,customer)(billing,finish))),
  ),
  (
    customer,
    \"-->"(customer, agency)(cancel, \"-->" (agency,hotel)(quote,finish))
  ),
)


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