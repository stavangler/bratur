import React from 'react'
import TripSummary from './trip-summary'
import {Link} from "react-router-dom"
import {useTrips} from "./use-trips"

export default function TripList() {
  const { trips, loading, error } = useTrips();

  if (error) {
    return <p>Error!</p>
  }

  return (
    <div className="project-list section">
      {
        loading ?
          <div className="preloader-wrapper small active">
          <div className="spinner-layer spinner-green-only">
            <div className="circle-clipper left">
              <div className="circle"/>
            </div>
            <div className="gap-patch">
              <div className="circle"/>
            </div>
            <div className="circle-clipper right">
              <div className="circle"/>
            </div>
          </div>
        </div>
          :
          trips.map((trip, index) => (
          <Link to={'/trip/' + trip.id} key={trip.id}>
            <TripSummary trip={trip}/>
          </Link>
        ))
      }
    </div>
  )
}

