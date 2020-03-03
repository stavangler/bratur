import React from 'react'
import {useStoreState} from "../../hooks"

type ParamsProps = {
  id: string
}

type MatchProps = {
  params: ParamsProps
}

type TripProps = {
  match: MatchProps
}

export default function TripDetails (props: TripProps) {
  const { id } = props.match.params
  const {items} = useStoreState(state => state.trips)
  const trip = items.find(t => t.id === id)

  return (
    <div className="container section project-details">
      <div className="card z-depth-0">
        <div className="card-content">
          <span className="card-title">{trip && trip.name}</span>
          <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Et labore quaerat quibusdam vel saepe, ab voluptate accusantium culpa nemo fuga earum? Soluta amet nobis officia sed neque fuga aperiam quia?</p>
        </div>
        <div className="card-action grey lighten-4 grey-text">
          <div>Posted by Someone</div>
          <div>2nd September, 13:37</div>
        </div>
      </div>
    </div>
  )
}
