import React from 'react'
import {Route, Switch} from 'react-router-dom'
import TripDrawer from './trip-drawer'
import TripInformation from './trip-information'
import TripAgenda from './trip-agenda'
import TripParticipants from './trip-participants'

interface ParamsProps {
  id: string
}

interface MatchProps {
  params: ParamsProps
  path: string
}

interface TripProps {
  match: MatchProps
}

export default function TripDetails(props: TripProps) {
  const {id} = props.match.params

  return (
    <div>
      <TripDrawer id={id}/>
      <main>
        <Switch>
          <Route exact path={props.match.path} component={TripInformation}/>
          <Route path={`${props.match.path}/agenda`} component={TripAgenda}/>
          <Route path={`${props.match.path}/participants`} component={TripParticipants}/>
        </Switch>
      </main>
    </div>
  )
}
