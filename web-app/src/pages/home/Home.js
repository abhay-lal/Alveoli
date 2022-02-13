import LandingPage from "./landingPage/LandingPage";
import "./Home.css";
import About from "./about/About";
import { Fragment } from "react";
import Categories from "./categories/Categories";
import Problem from "./problems/Problem";

const Home = () => {
  return (
    <Fragment>
      <LandingPage />
      <About />
      <Categories />
      <Problem />
    </Fragment>
  );
};

export default Home;
