// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Mpst$TravelAgency from "./mpst/Mpst.js";
import * as Protocol$TravelAgency from "./Protocol.js";

function Customer(Props) {
  var onclick = function (_e) {
    var ch_promise = Mpst$TravelAgency.connect(Protocol$TravelAgency.g, Protocol$TravelAgency.customer, "travel_agency", [
          "Customer",
          "Agency",
          "Hotel"
        ], "http://localhost:3050");
    ch_promise.then(function (ch) {
          var ch$1 = Mpst$TravelAgency.send(ch, (function (x) {
                  return {
                          NAME: "Agency",
                          VAL: x
                        };
                }), (function (x) {
                  return {
                          NAME: "reserve",
                          VAL: x
                        };
                }), "details");
          Mpst$TravelAgency.receive(ch$1, (function (x) {
                    return {
                            NAME: "Hotel",
                            VAL: x
                          };
                  })).then(function (param) {
                return Mpst$TravelAgency.close(param.VAL[1]);
              });
          
        });
    
  };
  return React.createElement("button", {
              onClick: onclick
            }, "customer");
}

var make = Customer;

var $$default = Customer;

export {
  make ,
  $$default ,
  $$default as default,
  
}
/* react Not a pure module */
