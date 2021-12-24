// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Mpst$TravelAgency from "./mpst/Mpst.js";

function lens_c_get(param) {
  return param[2];
}

function lens_c_put(param, c) {
  return [
          param[0],
          param[1],
          c
        ];
}

var lens_c = {
  get: lens_c_get,
  put: lens_c_put
};

function lens_s_get(param) {
  return param[1];
}

function lens_s_put(param, s) {
  return [
          param[0],
          s,
          param[2]
        ];
}

var lens_s = {
  get: lens_s_get,
  put: lens_s_put
};

function lens_a_get(param) {
  return param[0];
}

function lens_a_put(param, a) {
  return [
          a,
          param[1],
          param[2]
        ];
}

var lens_a = {
  get: lens_a_get,
  put: lens_a_put
};

var customer_role_label = {
  closed_match: (function (param) {
      return param.VAL;
    }),
  closed_make: (function (v) {
      return {
              NAME: "Customer",
              VAL: v
            };
    })
};

var customer = {
  role_label: customer_role_label,
  role_lens: lens_c
};

var service_role_label = {
  closed_match: (function (param) {
      return param.VAL;
    }),
  closed_make: (function (v) {
      return {
              NAME: "Service",
              VAL: v
            };
    })
};

var service = {
  role_label: service_role_label,
  role_lens: lens_s
};

var agency_role_label = {
  closed_match: (function (param) {
      return param.VAL;
    }),
  closed_make: (function (v) {
      return {
              NAME: "Agency",
              VAL: v
            };
    })
};

var agency = {
  role_label: agency_role_label,
  role_lens: lens_a
};

var price_label_closed = {
  closed_match: (function (param) {
      return param.VAL;
    }),
  closed_make: (function (v) {
      return {
              NAME: "price",
              VAL: v
            };
    })
};

function price_label_open(v) {
  return {
          NAME: "price",
          VAL: v
        };
}

var price = {
  label_closed: price_label_closed,
  label_open: price_label_open
};

var customer_option_label_closed = {
  closed_match: (function (param) {
      return param.VAL;
    }),
  closed_make: (function (v) {
      return {
              NAME: "customer_option",
              VAL: v
            };
    })
};

function customer_option_label_open(v) {
  return {
          NAME: "customer_option",
          VAL: v
        };
}

var customer_option = {
  label_closed: customer_option_label_closed,
  label_open: customer_option_label_open
};

var response_label_closed = {
  closed_match: (function (param) {
      return param.VAL;
    }),
  closed_make: (function (v) {
      return {
              NAME: "response",
              VAL: v
            };
    })
};

function response_label_open(v) {
  return {
          NAME: "response",
          VAL: v
        };
}

var response = {
  label_closed: response_label_closed,
  label_open: response_label_open
};

var g = Mpst$TravelAgency.$neg$neg$great(customer, service, price, Mpst$TravelAgency.$neg$neg$great(service, agency, customer_option, Mpst$TravelAgency.$neg$neg$great(agency, customer, response, Mpst$TravelAgency.finish)));

export {
  lens_c ,
  lens_s ,
  lens_a ,
  customer ,
  service ,
  agency ,
  price ,
  customer_option ,
  response ,
  g ,
  
}
/* g Not a pure module */