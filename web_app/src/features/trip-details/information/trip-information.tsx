import React, { useEffect } from "react"
import { useStoreActions, useStoreState } from "../../../store/hooks"
import {
  Container,
  Grid,
  IconButton,
  makeStyles,
  Typography,
} from "@material-ui/core"
import EditIcon from "@material-ui/icons/Edit"
import { useAuth } from "../../../components/auth/use-auth"
import { ReactRouterLink } from "../../react-router-link"
import { useParams } from "react-router-dom"

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
  image: {
    width: "100%",
    height: 500,
    objectFit: "cover",
    objectPosition: "center",
  },
}))

export default function TripInformation() {
  const { id } = useParams()
  const trip = useStoreState(state => state.tripInformation.data[0])
  const subscribe = useStoreActions(
    actions => actions.tripInformation.subscribe,
  )
  const classes = useStyles()
  const { user } = useAuth()

  useEffect(() => {
    if (id) {
      return subscribe(id)
    }
  }, [subscribe, id])

  if (!trip) {
    return null
  }

  return (
    <div>
      <img
        className={classes.image}
        src={trip.image.large}
        alt={trip.image.attribution}
      />

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
    </div>
  )
}
