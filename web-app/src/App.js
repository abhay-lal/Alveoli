import React, { Fragment, useEffect, useRef } from "react";
import Routes from "./Routes";
import alanBtn from "@alan-ai/alan-sdk-web";
import {useHistory} from 'react-router-dom'

function App() {
  const alanBtnContainer = useRef();
  const history = useHistory()

  useEffect(() => {
    alanBtn({
      key: "16e640254ab52f4aa02148c35fd8d1c92e956eca572e1d8b807a3e2338fdd0dc/stage",
      rootEl: alanBtnContainer.current,
      onCommand: (commandData) => {
        if (commandData.command === "showHomePage") {
          history.push('/')
        }
        if (commandData.command === "showLoginPage") {
          history.push("/login")
        }
        if (commandData.command === "showSignupPage") {
          history.push("/signup")
        }
        if (commandData.command === "showUploadPage") {
          if(localStorage.getItem("token")){
            history.push("/upload")
          }
          else {
            history.push("/login")
          }
        }
        if (commandData.command === "showProfilePage") {
          if(localStorage.getItem("token")){
          history.push("/profile")
          }else {
            history.push("/login")
          }
        }
      },
    });
  }, []);

  return (
    <Fragment>
      <Routes />
      <div className="App">
        <div ref={alanBtnContainer}></div>
      </div>
    </Fragment>
  );
}

export default App;
