import React from 'react'
import {useStoreState} from '../../hooks'
import {makeStyles, Paper, Container, Typography, IconButton} from '@material-ui/core'
import EditIcon from '@material-ui/icons/Edit'
import {useAuth} from '../auth/use-auth'
import {ReactRouterLink} from '../react-router-link'

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
  top: {
    display: 'flex',
  },
  title: {
    flexGrow: 1,
  },
  actions: {

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
}))

export default function TripInformation(props: TripProps) {
  const id = props.match.params.id
  const trip = useStoreState(state => state.trips.items.find(t => t.id === id))
  const classes = useStyles()
  const {user} = useAuth()

  return (
    <Container className={classes.container}>
      <Paper className={classes.paper}>
        <div className={classes.top}>
          <div className={classes.title}>
            <Typography variant="h2" component="h2">{trip && trip.name}</Typography>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Et labore quaerat quibusdam vel saepe, ab
              voluptate accusantium culpa nemo fuga earum? Soluta amet nobis officia sed neque fuga aperiam quia?</p>
          </div>
          {user && (
            <div className={classes.actions}>
              <IconButton aria-label="edit" title="Edit" component={ReactRouterLink} to={'/trip/' + id + '/edit'}>
                <EditIcon/>
              </IconButton>
            </div>
          )}
        </div>
        <div>
          <div>Posted by Someone</div>
          <div>2nd September, 13:37</div>
        </div>
      </Paper>
    </Container>
  )
}
