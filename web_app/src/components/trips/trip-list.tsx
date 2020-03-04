import React, {useEffect} from 'react'
import TripSummary from './trip-summary'
import {useStoreActions, useStoreState} from "../../hooks"
import {CircularProgress, Grid, makeStyles, Typography} from '@material-ui/core'

const useStyles = makeStyles(theme => ({
    root: {
      display: 'flex',
    },
    menuButton: {
      marginRight: 36,
    },
    paper: {
      padding: theme.spacing(2),
      display: 'flex',
      overflow: 'auto',
      flexDirection: 'column',
    },
    fixedHeight: {
      height: 240,
    },
  }),
)

export default function TripList() {
  const items = useStoreState(state => state.trips.items)
  const error = useStoreState(state => state.trips.error)
  const loading = useStoreState(state => state.trips.loading)
  const {fetch} = useStoreActions(actions => actions.trips)
  const classes = useStyles()

  useEffect(() => {
    fetch()
  }, [fetch])

  if (error) {
    return (
      <div className={classes.root}>
        <Typography variant="h1">Error!</Typography>
      </div>
    )
  }

  if (loading) {
    return <CircularProgress/>
  }

  return (
    <Grid container spacing={3}>
      {items.map((trip, index) => (
        <Grid item xs={12} md={8} lg={9} key={trip.id}>
            <TripSummary trip={trip}/>
        </Grid>
      ))
      }
    </Grid>
  )
}
