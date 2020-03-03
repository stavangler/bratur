import React from 'react'
import { Trip } from '../../model/trip'

type TripProps = {
  trip: Trip
}

function TripSummary (props: TripProps) {
  return (
    <div className="card z-depth-0 project-summary">
      <div className="card-content grey-text text-darken-3">
        <span className="card-title ">{props.trip.name}</span>
        <p>Posted by Someone</p>
        <p className="grey-text">3rd September, 13:37</p>
      </div>
    </div>
  )
}

export default TripSummary
