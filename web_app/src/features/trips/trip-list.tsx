import React, { useEffect } from "react"
import TripSummary from "./trip-summary"
import { useStoreActions, useStoreState } from "../../store/hooks"
import { CircularProgress, Grid } from "@material-ui/core"
import { Alert } from "@material-ui/lab"

export default function TripList() {
  const items = useStoreState(state => state.trips.data)
  const error = useStoreState(state => state.trips.error)
  const loading = useStoreState(state => state.trips.loading)
  const { subscribe } = useStoreActions(actions => actions.trips)

  useEffect(() => {
    return subscribe()
  }, [subscribe])

  if (error) {
    return (
      <Alert variant="filled" severity="error">
        Error!
      </Alert>
    )
  }

  if (loading) {
    return <CircularProgress />
  }

  return (
    <Grid container spacing={3}>
      {items.map(trip => (
        <Grid item xs={12} sm={6} lg={4} key={trip.id}>
          <TripSummary trip={trip} />
        </Grid>
      ))}
    </Grid>
  )
}
