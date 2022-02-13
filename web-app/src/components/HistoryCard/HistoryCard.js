import React, {useEffect,useState} from 'react'
import { MDBCard, MDBCardBody, MDBCardTitle, MDBCardText, MDBCardImage, MDBBtn, MDBCardFooter,MDBCol } from 'mdb-react-ui-kit';
function HistoryCard(props) {
  const [rDay, setRDay] = useState(0);
  const [rHour, setRHour] = useState(0);
  const [rMin, setRMin] = useState(0);
  function getTime() {
    const endTime = props&&props.data && props.data.createdAt;
    const time = new Date(endTime).getTime() - Date.now();
    const seconds = Math.abs(time / 1000);
    var d = Math.floor(seconds / (3600 * 24));
    var h = Math.floor((seconds % (3600 * 24)) / 3600);
    var m = Math.floor((seconds % 3600) / 60);
    setRDay(d)
    setRHour(h)
    setRMin(m)
  }
  useEffect(() => {
    const i = setInterval(getTime, 1000);
    return () => clearInterval(i);
  }, [props,rDay, rHour, rMin]);
  return (
  <div className="problem__cardsDiv card history__card" style={{ width: "22rem", padding: "0" }}>
  <img src={props&&props.data&&props.data.image} className="card-img-top" alt="..." height="250px"/>
  <div className="card-body text-start">
    <h5 className="card-title fs-3" style={{textTransform:'capitalize'}}>{props&&props.data&&props.data.result}</h5>
    <p className="card-text">
    {props&&props.data&&props.data.result==='normal'?(`Everything was found normal according to our prediciton.`):(`Our prediction led to the discovery of ${props&&props.data&&props.data.result}.`)}
    </p>
  </div>
  <div className="card-footer text-dark">
  <small className='text-dark'>Last updated {rDay>0&&rDay+' day'} {rHour>0&&rHour+' hour'} {rMin>0&&rMin+' mins'}  ago</small>
  </div>
</div>
  )
}


export default HistoryCard
