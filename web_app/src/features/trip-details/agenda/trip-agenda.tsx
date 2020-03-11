import React, { useEffect } from "react"
import { useStoreActions, useStoreState } from "../../../store/hooks"
import { Container, Grid, Typography } from "@material-ui/core"
import { useParams } from "react-router-dom"
import { makeStyles } from "@material-ui/core/styles"
import { AgendaEvent } from "./agenda-event"

const useStyles = makeStyles(theme => ({
  container: {
    paddingTop: theme.spacing(4),
    paddingBottom: theme.spacing(4),
  },
  expansionPanels: {
    width: "100%",
  },
}))

export default function TripAgenda() {
  const { id } = useParams()
  const classes = useStyles()

  const { subscribe } = useStoreActions(actions => actions.agenda)
  const data = useStoreState(state => state.agenda.data)

  useEffect(() => {
    if (id) {
      return subscribe(id)
    }
  }, [subscribe, id])

  return (
    <Container maxWidth="lg" className={classes.container}>
      <Grid container spacing={2}>
        <Grid item xs={12}>
          <Typography variant="h3">Agenda</Typography>
        </Grid>

        <Grid item className={classes.expansionPanels}>
          {data.map(item => (
            <AgendaEvent key={item.id} item={item} />
          ))}
        </Grid>
      </Grid>
    </Container>
  )
}
