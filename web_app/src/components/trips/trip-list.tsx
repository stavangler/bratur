import React, {useEffect} from 'react'
import TripSummary from './trip-summary'
import {Link} from 'react-router-dom'
import {useStoreActions, useStoreState} from "../../hooks"

export default function TripList() {
  const {items, error, loading} = useStoreState(state => state.trips)
  const {fetch} = useStoreActions(actions => actions.trips)

  useEffect(() => {
    fetch()
  }, [fetch])

  if (error) {
    return <p>Error!</p>
  }

  return (
    <div className="project-list section">
      {
        loading
          ? <div className="preloader-wrapper small active">
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
          : items.map((trip, index) => (
            <Link to={'/trip/' + trip.id} key={trip.id}>
              <TripSummary trip={trip}/>
            </Link>
          ))
      }
    </div>
  )
}
