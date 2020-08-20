import React from "react"
import TripList from "../trips/trip-list"
import { Container, makeStyles, Theme } from "@material-ui/core"

const useStyles = makeStyles((theme: Theme) => ({
  container: {
    paddingTop: theme.spacing(4),
    paddingBottom: theme.spacing(4),
  },
}))

function Dashboard() {
  const classes = useStyles()

  return (
    <main>
      <Container maxWidth="lg" className={classes.container}>
        <TripList />
      </Container>
    </main>
  )
}

export default Dashboard
