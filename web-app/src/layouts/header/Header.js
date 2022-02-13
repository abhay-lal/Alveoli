import logo from '../../assets/logo.png';
import pddf from '../../assets/whitepaper.pdf'
import LoadingSpinner from '../../components/LoadingSpinner/LoadingSpinner';
import "./Header.css";
import React, { Fragment, useEffect, useState } from 'react';
import axios from 'axios';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import {
  MDBNavbar,
  MDBContainer,
  MDBIcon,
  MDBNavbarNav,
  MDBNavbarItem,
  MDBNavbarLink,
  MDBNavbarToggler,
  MDBNavbarBrand,
  MDBCollapse
} from 'mdb-react-ui-kit';
import { useLocation, useHistory } from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import { authAction } from "../../store";
toast.configure();

const Header = () => {
  const [loading, setLoading] = useState(false);
  const location = useLocation();
  const pathname = location.pathname;
  const [showNavColor, setShowNavColor] = useState(false);
  const authCtx = useSelector(state => state.user);
  const dispatch = useDispatch();
  const history = useHistory()

  const logOutHandler=async (event)=>{
    event.preventDefault();
        setLoading(true);
        try {
          const token = localStorage.getItem('token');
          const response = await axios
          .get(
            'https://nakshatra-demo.herokuapp.com/api/users/logout',
            { headers: { "Authorization": `Bearer ${token}` }, withCredentials: true }
            );
            if (response) {
              localStorage.removeItem('token')
              toast.success(`Logout Success`, {
                position: toast.POSITION.TOP_RIGHT
              });
              history.push("/")
              window.location.href = "/"
            }
            setLoading(false);
        } catch (error) {
            console.log(error);
            setLoading(false);
            toast.error(error.response.data.message, {
                position: toast.POSITION.TOP_RIGHT
            });
  }
}
  useEffect(() => {
    const token = localStorage.getItem('token');
    const getTodo = () => {
      axios
        .get('https://nakshatra-demo.herokuapp.com/api/users/me', { headers: { "Authorization": `Bearer ${token}` }, withCredentials: true })
        .then((response) => {
          dispatch(authAction.setData(response.data.data));
        })
        .catch((e) => {
          console.log(e);
          toast.error(e.response.data.message, {
            position: toast.POSITION.TOP_RIGHT
          });
        });
    };
    if (token) {
      getTodo();
    }
  }, []);
  return (
    <Fragment>
    {loading&&<LoadingSpinner/>}
      <MDBNavbar expand='lg' dark className="bgs">
        <MDBNavbarBrand href='/' >
          <img
            src={logo}
            height='80'
            alt=''
            loading='lazy'
          />
          Alveoli
        </MDBNavbarBrand>
        <MDBContainer fluid>
          <MDBNavbarToggler
            type='button'
            data-target='#navbarColor02'
            aria-controls='navbarColor02'
            aria-expanded='false'
            aria-label='Toggle navigation'
            onClick={() => setShowNavColor(!showNavColor)}
          >
            <MDBIcon icon='bars' fas />
          </MDBNavbarToggler>
          <MDBCollapse show={showNavColor} center navbar>
            <MDBNavbarNav className='justify-content-end mb-2 mb-lg-0 px-5'>
              <MDBNavbarItem className="mx-4">
                <MDBNavbarLink href='/upload' active={"/upload" === pathname}>Upload</MDBNavbarLink>
              </MDBNavbarItem>
              <MDBNavbarItem className="mx-4">
                <MDBNavbarLink href={pddf} download>WhitePaper</MDBNavbarLink>
              </MDBNavbarItem>
              {authCtx && authCtx.name ?
              (<Fragment>
              <MDBNavbarItem className="mx-4">
                <MDBNavbarLink href='/profile' active={"/profile" === pathname}>Profile</MDBNavbarLink>
              </MDBNavbarItem>
              <MDBNavbarItem className="mx-4">
                <MDBNavbarLink onClick={logOutHandler}>Logout</MDBNavbarLink>
              </MDBNavbarItem>
              </Fragment>
              ) : (
                <Fragment>
                <MDBNavbarItem className="mx-4">
                <MDBNavbarLink href='/login' active={"/login" === pathname}>Login</MDBNavbarLink>
              </MDBNavbarItem>
              <MDBNavbarItem className="mx-4">
                <MDBNavbarLink href='/signup' active={"/signup" === pathname}>Signup</MDBNavbarLink>
              </MDBNavbarItem>
              </Fragment>)}
            </MDBNavbarNav>
          </MDBCollapse>
        </MDBContainer>
      </MDBNavbar>
    </Fragment>
  );
};

export default Header;