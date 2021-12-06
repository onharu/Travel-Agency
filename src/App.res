/*
%%raw(`
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
`)
*/

%%raw(`
import './App.css';

`)


@react.component
let make = () => {
  let (user,setuser) = React.useState(_ => "")
  let onclickC = (_e) => {setuser(_ => "customer")}
  let onclickS = (_e) => {setuser(_ => "service")}
  let onclickA = (_e) => {setuser(_ => "agency")}
  <div className="App">
    {if (user == "")
        {<div>
            <div>{React.string("No user")}</div>
            <button onClick={onclickC}> {React.string("Customer")} </button>
            <button onClick={onclickS}> {React.string("Service")} </button>
            <button onClick={onclickA}> {React.string("Agency")} </button>
         </div>}
        else {<div/>}}

    {if (user === "customer")  
        {<Customer/>}
        else {<div/>}}

    {if (user === "service") 
        {<Service/>}
        else {<div/>}}

    {if (user === "agency")  
        {<Agency/>}
        else {<div/>}}

  </div>
}

let default = make
