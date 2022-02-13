import React, { useState, Fragment } from "react";
import LoadingSpinner from "../../components/LoadingSpinner/LoadingSpinner";
import { toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import axios from "axios";
import "./style.css";
toast.configure();

function ForgotPassword() {
  const [loading, setLoading] = useState(false);
  const [details, setdetails] = useState({
    email: "",
  });
  const handleSumbit = async (event) => {
    event.preventDefault();
    setLoading(true);
    try {
      const data = details;
      const response = await axios.post(
        "https://nakshatra-demo.herokuapp.com/api/users/forgotPassword",
        data
      );
      setdetails({
        email: "",
      });
      if (response) {
        toast.success(response.data.message, {
          position: toast.POSITION.TOP_RIGHT,
        });
      }
      setLoading(false);
    } catch (error) {
      console.log(error);
      setLoading(false);
      toast.error(error.response.data.message, {
        position: toast.POSITION.TOP_RIGHT,
      });
    }
  };
  return (
    <Fragment>
      {loading && <LoadingSpinner />}
      <div className="container">
        <div className="login__container">
          <form onSubmit={handleSumbit}>
            <h3 style={{color: "#064848"}}>Forgot Password</h3>

            <div className="login__inputDiv form-group">
              <label><p className="mb-1">Password</p></label>
              <input
                type="email"
                className="form-control"
                placeholder="Enter email"
                value={details.email}
                onChange={(e) =>
                  setdetails({ ...details, email: e.target.value })
                }
                required
              />
            </div>
            <button type="submit" className="login__btn btn btn-dark btn-lg btn-block">
              Send Reset Link
            </button>
            <p className="forgot-password text-right">
              Forgot <a href="#" style={{textDecoration: "none", color: "#064848"}}>password?</a>
            </p>
          </form>
        </div>
      </div>
    </Fragment>
  );
}

export default ForgotPassword;
