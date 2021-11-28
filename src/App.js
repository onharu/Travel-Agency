// Generated by ReScript, PLEASE EDIT WITH CARE


import './App.css';
import Customer from './Customer'
import Service from './Service'
import Agency from './Agency'
import React, {useState} from 'react';


function App () {
  const[user, setuser] = useState()
  return (
    <div>
      {user == null &&
        <div>
          <div>No user.</div>
          <button onClick={() => setuser("customer")}>Customer</button>
          <button onClick={() => setuser("service")}>Service</button>
          <button onClick={() => setuser("agency")}>Agency</button>
        </div>}
      {user === "customer" && <Customer/>}
      {user === "service" && <Service/>}
      {user === "agency" && <Agency/>}
    </div>
  )
}

export default App;
;

export {
  
}
/*  Not a pure module */
