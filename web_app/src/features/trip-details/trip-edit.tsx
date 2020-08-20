import React from "react"
import { useStoreState } from "../../store/hooks"
import {
  makeStyles,
  Paper,
  Container,
  IconButton,
  TextField,
} from "@material-ui/core"
import SaveIcon from "@material-ui/icons/Save"

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
  form: {
    margin: theme.spacing(1),
    width: 200,
  },
  title: {
    flexGrow: 1,
  },
  actions: {},
  container: {
    paddingTop: theme.spacing(4),
    paddingBottom: theme.spacing(4),
  },
  paper: {
    display: "flex",
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

export default function TripEdit(props: TripProps) {
  const trip = useStoreState(state =>
    state.trips.data.find(t => t.id === props.match.params.id),
  )
  const classes = useStyles()

  return (
    <Container className={classes.container}>
      <Paper className={classes.paper}>
        <form className={classes.form} noValidate autoComplete="off">
          <TextField
            required
            label="Trip name"
            defaultValue={trip ? trip.name : ""}
          />
          <p>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Et labore
            quaerat quibusdam vel saepe, ab voluptate accusantium culpa nemo
            fuga earum? Soluta amet nobis officia sed neque fuga aperiam quia?
          </p>
        </form>
        <div className={classes.actions}>
          <IconButton aria-label="save" title="Save">
            <SaveIcon />
          </IconButton>
        </div>
        <div>
          <div>Posted by Someone</div>
          <div>2nd September, 13:37</div>
        </div>
      </Paper>
    </Container>
  )
}
