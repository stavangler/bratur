import React from 'react'
import {Trip} from '../../model/trip'
import {Button, Card, CardActions, CardContent, Typography, makeStyles} from '@material-ui/core'
import {ReactRouterLink} from "../react-router-link"

type TripProps = {
  trip: Trip
}

const useStyles = makeStyles(theme => ({
    root: {
      minWidth: 275,
    },
    bullet: {
      display: 'inline-block',
      margin: '0 2px',
      transform: 'scale(0.8)',
    },
    pos: {
      marginBottom: 12,
    },
    actions: {
      backgroundColor: theme.palette.grey["600"],
      color: theme.palette.getContrastText(theme.palette.grey["600"]),
    },
  }),
)

function TripSummary(props: TripProps) {
  const classes = useStyles()
  return (
    <Card className={classes.root}>
      <CardContent>
        <Typography component="h2" variant="h6" color="textSecondary" gutterBottom>
          {props.trip.name}
        </Typography>
        <Typography className={classes.pos} color="textSecondary">
          Posted by Someone
        </Typography>
        <Typography variant="body2" component="p">
          3rd September, 13:37
        </Typography>
      </CardContent>
      <CardActions className={classes.actions}>
        <Button size="small" color="inherit" component={ReactRouterLink} to={'/trip/' + props.trip.id}>Trip details</Button>
      </CardActions>
    </Card>
  )
}

export default TripSummary
