// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as Raw$TravelAgency from "./Raw.js";
import * as SocketIoClient from "socket.io-client";
import * as RawTransport$TravelAgency from "./RawTransport.js";

function list_match(param, param$1) {
  return Raw$TravelAgency.assertfalse(undefined);
}

function role_to_tag(role) {
  return Raw$TravelAgency.destruct_polyvar(Curry._1(role.role_label.closed_make, Raw$TravelAgency.dontknow(undefined)))[0];
}

function open_variant_to_tag($$var) {
  return Raw$TravelAgency.destruct_polyvar(Curry._1($$var, Raw$TravelAgency.dontknow(undefined)))[0];
}

function connect(_g, role, protocolname, roles, url) {
  return new Promise((function (resolve, _reject) {
                var socket = SocketIoClient.io(url, {
                      autoConnect: false
                    });
                var match = Raw$TravelAgency.destruct_polyvar(Curry._1(role.role_label.closed_make, Raw$TravelAgency.dontknow(undefined)));
                socket.auth = {
                  username: match[0],
                  protocolname: protocolname,
                  rolenames: roles
                };
                socket.connect();
                socket.on("participants", (function (_msg) {
                        console.log("recieve");
                        return resolve({
                                    dummy_witness: Raw$TravelAgency.dontknow(undefined),
                                    mpchan: socket
                                  });
                      }));
                
              }));
}

function send(sess, role, label, v) {
  var roletag = open_variant_to_tag(role);
  var labeltag = open_variant_to_tag(label);
  RawTransport$TravelAgency.raw_send(sess.mpchan, roletag, labeltag, v);
  return {
          dummy_witness: Raw$TravelAgency.dontknow(undefined),
          mpchan: sess.mpchan
        };
}

function receive(sess, role) {
  var roletag = open_variant_to_tag(role);
  return RawTransport$TravelAgency.raw_receive(sess.mpchan, roletag).then(function (param) {
              var cont_dummy_witness = Raw$TravelAgency.dontknow(undefined);
              var cont_mpchan = sess.mpchan;
              var cont = {
                dummy_witness: cont_dummy_witness,
                mpchan: cont_mpchan
              };
              return Raw$TravelAgency.make_polyvar(param[0], [
                          param[1],
                          cont
                        ]);
            });
}

function close(param) {
  
}

function $neg$neg$great(_from, _to, _label, _next) {
  return Raw$TravelAgency.dontknow(undefined);
}

var finish = Raw$TravelAgency.dontknow(undefined);

function choice_at(_role, _disj, param, param$1) {
  return Raw$TravelAgency.dontknow(undefined);
}

function extract(_g, _role) {
  return Raw$TravelAgency.todo(undefined);
}

export {
  list_match ,
  role_to_tag ,
  open_variant_to_tag ,
  connect ,
  send ,
  receive ,
  close ,
  $neg$neg$great ,
  finish ,
  choice_at ,
  extract ,
  
}
/* finish Not a pure module */
