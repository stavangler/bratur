import React from 'react'
import {useStoreState} from '../../hooks'

interface ParamsProps {
  id: string
}

interface MatchProps {
  params: ParamsProps
}

interface TripProps {
  match: MatchProps
}

export default function TripInformation(props: TripProps) {
  const trip = useStoreState(state => state.trips.items.find(t => t.id === props.match.params.id))

  return (
    <div>
      <div className="card-content">
        <span className="card-title">{trip && trip.name}</span>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Et labore quaerat quibusdam vel saepe, ab
          voluptate accusantium culpa nemo fuga earum? Soluta amet nobis officia sed neque fuga aperiam quia?</p>
      </div>
      <div className="card-action grey lighten-4 grey-text">
        <div>Posted by Someone</div>
        <div>2nd September, 13:37</div>
      </div>
    </div>
  )
}
