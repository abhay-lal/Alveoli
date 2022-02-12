import LandingPage from "./landingPage/LandingPage";
import "./Home.css";
import About from "./about/About";
import { Fragment } from "react";

const Home = () => {
  return (
    <Fragment>
      <LandingPage />
      <About />
    </Fragment>
  );
};

export default Home;
