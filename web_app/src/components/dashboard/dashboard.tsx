import React from 'react'
import TripList from '../trips/trip-list'
import {Container, Grid, makeStyles} from "@material-ui/core";

const useStyles = makeStyles(theme => ({
    root: {
      display: 'flex',
    },
    menuButton: {
      marginRight: 36,
    },
    content: {
      flexGrow: 1,
      height: '100vh',
      overflow: 'auto',
    },
    container: {
      paddingTop: theme.spacing(4),
      paddingBottom: theme.spacing(4),
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

function Dashboard() {
  const classes = useStyles()

  return (
    <main>
      <Container maxWidth="lg" className={classes.container}>
        <Grid container spacing={3}>
          <TripList/>
        </Grid>
      </Container>
    </main>
  )
}

export default Dashboard
