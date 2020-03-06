import React from 'react'
import {useStoreState} from '../../hooks'
import {makeStyles, Paper} from '@material-ui/core'

interface ParamsProps {
  id: string
}

interface MatchProps {
  params: ParamsProps
}

interface TripProps {
  match: MatchProps
}

const useStyles = makeStyles(theme => ({
    title: {
      flexGrow: 1,
    },
    container: {
      paddingTop: theme.spacing(4),
      paddingBottom: theme.spacing(4),
    },
    paper: {
      marginTop: theme.spacing(3),
      marginBottom: theme.spacing(3),
      padding: theme.spacing(2),
      [theme.breakpoints.up(600 + theme.spacing(3) * 2)]: {
        marginTop: theme.spacing(6),
        marginBottom: theme.spacing(6),
        padding: theme.spacing(3),
      },
    },
  }),
)

export default function TripInformation(props: TripProps) {
  const trip = useStoreState(state => state.trips.items.find(t => t.id === props.match.params.id))
  const classes = useStyles()

  return (
    <Paper className={classes.paper}>
      <div>
        <span className={classes.title}>{trip && trip.name}</span>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Et labore quaerat quibusdam vel saepe, ab
          voluptate accusantium culpa nemo fuga earum? Soluta amet nobis officia sed neque fuga aperiam quia?</p>
      </div>
      <div>
        <div>Posted by Someone</div>
        <div>2nd September, 13:37</div>
      </div>
    </Paper>
  )
}
