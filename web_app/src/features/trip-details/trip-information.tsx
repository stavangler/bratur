import React from "react"
import { useStoreState } from "../../store/hooks"
import {
  Container,
  Grid,
  IconButton,
  makeStyles,
  Typography,
} from "@material-ui/core"
import EditIcon from "@material-ui/icons/Edit"
import { useAuth } from "../../components/auth/use-auth"
import { ReactRouterLink } from "../react-router-link"

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
    display: "flex",
  },
  title: {
    flexGrow: 1,
  },
  actions: {},
  container: {
    paddingTop: theme.spacing(4),
    paddingBottom: theme.spacing(4),
  },
}))

export default function TripInformation(props: TripProps) {
  const id = props.match.params.id
  const trip = useStoreState(state => state.trips.items.find(t => t.id === id))
  const classes = useStyles()
  const { user } = useAuth()

  return (
    <Container className={classes.container} maxWidth="lg">
      <Grid container spacing={2}>
        <Grid item className={classes.top}>
          <div className={classes.title}>
            <Typography variant="h3">{trip && trip.name}</Typography>
          </div>
          {user && (
            <div className={classes.actions}>
              <IconButton
                aria-label="edit"
                title="Edit"
                component={ReactRouterLink}
                to={"/trip/" + id + "/edit"}
              >
                <EditIcon />
              </IconButton>
            </div>
          )}
        </Grid>

        <Grid item>
          <Typography variant="subtitle1">
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Et labore
            quaerat quibusdam vel saepe, ab voluptate accusantium culpa nemo
            fuga earum? Soluta amet nobis officia sed neque fuga aperiam quia?
          </Typography>
        </Grid>

        <Grid item>
          <Typography variant="caption">2nd September, 13:37</Typography>
        </Grid>
      </Grid>
    </Container>
  )
}
