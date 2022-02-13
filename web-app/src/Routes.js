import { Redirect, Route, Switch } from "react-router-dom";
import Protected from "./PrivateRoute";
import Layout from "./layouts/Layout";
import Home from "./pages/home/Home";
import Profile from "./pages/profile/Profile";
import UploadImage from "./pages/uploadImage/UploadImage";
import Login from './pages/login/Login';
import SignUp from './pages/login/SignUp';
import ForgotPassword from "./pages/login/ForgotPassword";
import ResetPassword from "./pages/login/ResetPassword";
import KnowMore from "./pages/knowMore/KnowMore";
const Routes = () => {
    return (
        <Layout>
            <Switch>
                <Route path='/' exact>
                <Home />
                </Route>
                <Protected exact path="/upload" component={UploadImage} />
                <Protected exact path="/profile" component={Profile} />
                <Route path="/knowmore/:result" exact>
                    <KnowMore />
                </Route>
                <Route path="/login" exact>
                    <Login />
                </Route>
                <Route path="/signup" exact>
                    <SignUp />
                </Route>
                <Route path="/forgotPassword" exact>
                    <ForgotPassword />
                </Route>
                <Route path="/resetPassword/:id" exact>
                    <ResetPassword />
                </Route>
                <Route path="*">
                    <Redirect to="/"/>
                </Route>
            </Switch>
        </Layout>
    );
}

export default Routes;