import React from 'react'
import { Redirect, Route } from 'react-router-dom'
const Protected = ({ component: Cmp }) => {
  const parseJwt = (token) => {
    try {
      const data= JSON.parse(atob(token.split('.')[1]));
      let tokenExpiration = data.exp;
            let dateNow = new Date();
            if(tokenExpiration < dateNow.getTime()/1000){
                return false;
            }else{
                return true;
            }
    } catch (e) {
      return null;
    }

  };
  return (

    <Route render={() => localStorage.getItem('token') && parseJwt(localStorage.getItem('token'))? <Cmp /> : <Redirect to='/login' />} />
  )
}

export default Protected;