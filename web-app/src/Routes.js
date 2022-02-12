import { BrowserRouter, Route, Switch } from "react-router-dom";
import Layout from "./layouts/Layout";
import Home from "./pages/home/Home";
import UploadImage from "./pages/uploadImage/UploadImage";

const Routes = () => {
    return (
        <BrowserRouter>
            <Layout>
                <Switch>
                    <Route path="/" exact>
                        <Home />
                    </Route>
                    <Route path="/upload">
                        <UploadImage />
                    </Route>
                </Switch>
            </Layout>
        </BrowserRouter>
    );
}

export default Routes;