import "./About.css";

// assets imports
import aboutImg from "../../../assets/about1.jpg";

const About = () => {
  return (
    <div className="about__container d-flex flex-column align-items-center justify-content-center">
      <div className="about__sectionHeading d-flex flex-column align-items-center justify-content-cente">
        <p className="my-0">What We Do ?</p>
        <div className="about__borderDiv"></div>
      </div>
      <div className="about__containerDiv">
        <div className="about__infoContainer">
          <div className="about__infoTextHeading"><p>About Alveoli</p></div>
          <div className="about__infoTextPara">
            <p>
            This project helps users check their Chest X-Ray reports in a matter of seconds.We have created a secure Chest X-Ray image classification based website and app that can detect Covid-19, Pneumonia and Tuberculosis. Deep Learning has been used to detect the disease by using a Convolutional Neural Network(MobileNetV2) which performs classification
            </p>
            <p>
            The user can login and upload an image of the Chest X-Ray which will be safely secured on Blockchain.The result of Chest X-Ray shall be given within seconds. In our website we have integrated Alan AI to provide a smooth workflow for all.The user can also view a history of their medical chest X-Ray reports which can be downloaded in the form of a pdf.
            </p>
          </div>
        </div>
        <div className="about__imgContainer text-center">
            <div className="about__imgDiv">
                <img src={aboutImg} alt="about Image" />
            </div>
        </div>
      </div>
    </div>
  );
};

export default About;
