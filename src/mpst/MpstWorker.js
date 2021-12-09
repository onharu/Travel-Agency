// Generated by ReScript, PLEASE EDIT WITH CARE

import * as $$Array from "rescript/lib/es6/array.js";
import * as Curry from "rescript/lib/es6/curry.js";
import * as Js_dict from "rescript/lib/es6/js_dict.js";
import * as Js_list from "rescript/lib/es6/js_list.js";
import * as Belt_Array from "rescript/lib/es6/belt_Array.js";
import * as Caml_array from "rescript/lib/es6/caml_array.js";
import * as Raw$TravelAgency from "./Raw.js";
import * as WebWorker$TravelAgency from "./WebWorker.js";

function make_ports(roles) {
  var cnt = roles.length;
  var arr = Belt_Array.makeBy(cnt, (function (i) {
          return Belt_Array.makeBy(i + 1 | 0, (function (param) {
                        return new MessageChannel();
                      }));
        }));
  return Js_dict.fromList(Js_list.init(cnt, (function (i) {
                    var portlist = Js_list.init(cnt, (function (j) {
                            var port = j < i || j <= i ? Caml_array.get(Caml_array.get(arr, i), j).port1 : Caml_array.get(Caml_array.get(arr, j), i).port2;
                            return [
                                    Caml_array.get(roles, j),
                                    port
                                  ];
                          }));
                    return [
                            Caml_array.get(roles, i),
                            Js_dict.fromList(portlist)
                          ];
                  })));
}

function newWorker(prim) {
  return prim;
}

function initWorkers0(mainrole, workers) {
  var worker_roles = $$Array.map((function (param) {
          return param[0];
        }), workers);
  var roles = $$Array.append([mainrole], worker_roles);
  var ports_map = make_ports(roles);
  workers.map(function (param) {
        var ports = ports_map[param[0]];
        var transfers = Js_dict.values(ports).map(function (prim) {
              return prim;
            });
        param[1].postMessage(ports, transfers);
        
      });
  return ports_map[mainrole];
}

function initWorkers(_g, mainrole, workers) {
  var match = Raw$TravelAgency.destruct_polyvar(Curry._1(mainrole.role_label.closed_make, Raw$TravelAgency.dontknow(undefined)));
  var mpchan = initWorkers0(match[0], workers);
  return {
          dummy_witness: Raw$TravelAgency.dontknow(undefined),
          mpchan: mpchan
        };
}

var MainSide = {
  make_ports: make_ports,
  newWorker: newWorker,
  initWorkers0: initWorkers0,
  initWorkers: initWorkers
};

function init(_g, _role) {
  return new Promise((function (resolve, _reject) {
                return WebWorker$TravelAgency.WorkerSide.setOnMessage(function (e) {
                            var sess_dummy_witness = Raw$TravelAgency.dontknow(undefined);
                            var sess_mpchan = e.data;
                            var sess = {
                              dummy_witness: sess_dummy_witness,
                              mpchan: sess_mpchan
                            };
                            return resolve(sess);
                          });
              }));
}

var WorkerSide = {
  init: init
};

export {
  MainSide ,
  WorkerSide ,
  
}
/* No side effect */
