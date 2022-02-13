import React, { useState, Fragment } from "react";
import LoadingSpinner from "../../components/LoadingSpinner/LoadingSpinner";
import { toast } from "react-toastify";
import { useParams } from "react-router-dom";
import "react-toastify/dist/ReactToastify.css";
import axios from "axios";
import "./style.css";
import { useSelector, useDispatch } from "react-redux";
import { authAction } from "../../store";
toast.configure();

function ResetPassword() {
  const params = useParams();
  const [loading, setLoading] = useState(false);
  const [details, setdetails] = useState({
    password: "",
    passwordConfirm: "",
  });
  const authCtx = useSelector((state) => state.user);
  const dispatch = useDispatch();

  const handleSumbit = async (event) => {
    event.preventDefault();
    setLoading(true);
    try {
      const data = details;
      if (!(data.password === data.passwordConfirm)) {
        setLoading(false);
        toast.warn("Password Do Not Match !", {
          position: toast.POSITION.TOP_RIGHT,
        });
        return;
      }
      const response = await axios.patch(
        `https://nakshatra-demo.herokuapp.com/api/users/resetPassword/${
          params && params.id && params.id
        }`,
        data
      );
      if (response) {
        dispatch(authAction.updateData(response.data));
        toast.success("Password Reset !", {
          position: toast.POSITION.TOP_RIGHT,
        });
      }
      setdetails({
        password: "",
        passwordConfirm: "",
      });
      setLoading(false);
      window.location = "/profile";
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
            <h3 style={{color: "#064848"}}>Password Reset</h3>
            <div className="login__inputDiv form-group">
              <label><p className="mb-1">Password</p></label>
              <input
                type="password"
                className="form-control"
                placeholder="Enter password"
                value={details.password}
                onChange={(e) =>
                  setdetails({ ...details, password: e.target.value })
                }
                required
              />
            </div>

            <div className="login__inputDiv form-group">
              <label><p className="mb-1">Confirm Password</p></label>
              <input
                type="password"
                className="form-control"
                placeholder="Enter password"
                value={details.passwordConfirm}
                onChange={(e) =>
                  setdetails({ ...details, passwordConfirm: e.target.value })
                }
                required
              />
            </div>

            <button type="submit" className="login__btn btn btn-dark btn-lg btn-block">
              Reset Password
            </button>
            <p className="forgot-password text-right">
              Forgot <a href="/forgotPassword" style={{textDecoration: "none", color: "#064848"}}>password?</a>
            </p>
          </form>
        </div>
      </div>
    </Fragment>
  );
}

export default ResetPassword;
