%%raw(`
import './App.css';

`)


@react.component
let make = () => {
  let (user,setuser) = React.useState(_ => "")
  let onclickC = (_e) => {setuser(_ => "customer")}
  let onclickS = (_e) => {setuser(_ => "hotel")}
  let onclickA = (_e) => {setuser(_ => "agency")}
  <div className="App">
    {if (user == "")
        {<div>
            <div>{React.string("No user")}</div>
            <button onClick={onclickC}> {React.string("Customer")} </button>
            <button onClick={onclickA}> {React.string("Agency")} </button>
            <button onClick={onclickS}> {React.string("Hotel")} </button>
            
         </div>}
        else {<div/>}}

    {if (user === "customer")  
        {<Customer/>}
        else {<div/>}}

    {if (user === "agency")  
        {<Agency/>}
        else {<div/>}}

    {if (user === "hotel") 
        {<Hotel/>}
        else {<div/>}}


  </div>
}

let default = make
