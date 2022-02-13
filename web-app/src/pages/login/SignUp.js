import React, { useState } from "react";
import axios from "axios";
import { useSelector, useDispatch } from "react-redux";
import { authAction } from "../../store";
import LoadingSpinner from "../../components/LoadingSpinner/LoadingSpinner";
import "./style.css";
import { toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
toast.configure();

function SignUp() {
  const [loading, setLoading] = useState(false);
  const [details, setdetails] = useState({
    name: "",
    email: "",
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
      const response = await axios.post(
        "https://nakshatra-demo.herokuapp.com/api/users/signup",
        data
      );
      if (response) {
        dispatch(authAction.updateData(response.data));
        toast.success(`Welcome ${response.data.data.user.name}`, {
          position: toast.POSITION.TOP_RIGHT,
        });
      }
      setdetails({
        name: "",
        email: "",
        password: "",
        passwordConfirm: "",
      });
      setLoading(false);
      window.location = "/upload";
    } catch (error) {
      console.log(error);
      setLoading(false);
      toast.error(error.response.data.message, {
        position: toast.POSITION.TOP_RIGHT,
      });
    }
  };
  return (
    <div className="bg">
      {loading && <LoadingSpinner />}
      <div className="container">
        <div className="login__container">
          <form onSubmit={handleSumbit}>
            <h3 style={{color: "#064848"}}>Register</h3>

            <div className="login__inputDiv form-group">
              <label>Name</label>
              <input
                type="text"
                className="form-control"
                placeholder="Name"
                value={details.name}
                onChange={(e) =>
                  setdetails({ ...details, name: e.target.value })
                }
                required
              />
            </div>

            <div className="login__inputDiv form-group">
              <label><p className="mb-1">Email</p></label>
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
              Register
            </button>
            <p className="forgot-password text-right">
              Already registered <a href="/login" style={{textDecoration: "none", color: "#064848"}}>log in?</a>
            </p>
          </form>
        </div>
      </div>
    </div>
  );
}

export default SignUp;
