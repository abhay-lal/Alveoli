import { Fragment } from "react/cjs/react.production.min";
import Header from "./header/Header";
import Footer from "./footer/Footer";

const Layout = (props) => {
    return (
        <Fragment>
            <Header />
            {props.children}
            <Footer />
        </Fragment>
    );
}

export default Layout;