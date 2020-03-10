import React from "react"
import { Route, Switch } from "react-router-dom"
import TripDrawer from "../trips/trip-drawer"
import TripInformation from "./information/trip-information"
import TripAgenda from "./agenda/trip-agenda"
import TripParticipants from "./participants/trip-participants"
import { makeStyles } from "@material-ui/core"
import TripEdit from "./trip-edit"

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

const useStyles = makeStyles(theme => ({
  root: {
    display: "flex",
  },
  content: {
    flexGrow: 1,
    height: "100vh",
    overflow: "auto",
  },
}))

export default function TripDetails(props: TripProps) {
  const { id } = props.match.params
  const classes = useStyles()

  return (
    <div className={classes.root}>
      <TripDrawer id={id} />
      <main className={classes.content}>
        <Switch>
          <Route exact path={props.match.path} component={TripInformation} />
          <Route path={`${props.match.path}/edit`} component={TripEdit} />
          <Route path={`${props.match.path}/agenda`} component={TripAgenda} />
          <Route
            path={`${props.match.path}/participants`}
            component={TripParticipants}
          />
        </Switch>
      </main>
    </div>
  )
}
