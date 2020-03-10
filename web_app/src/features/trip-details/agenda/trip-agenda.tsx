import React, { useEffect } from "react"
import { useStoreActions, useStoreState } from "../../../store/hooks"
import {
  Container,
  ExpansionPanel,
  ExpansionPanelSummary,
  Grid,
  Typography,
} from "@material-ui/core"
import { useParams } from "react-router-dom"
import { makeStyles } from "@material-ui/core/styles"
import ExpandMoreIcon from "@material-ui/icons/ExpandMore"
import LocationOnIcon from "@material-ui/icons/LocationOn"

const useStyles = makeStyles(theme => ({
  container: {
    paddingTop: theme.spacing(4),
    paddingBottom: theme.spacing(4),
  },
  expansionPanels: {
    width: "100%",
  },
  dot: {
    height: 12,
    width: 12,
    borderRadius: "50%",
    display: "inline-block",
  },
  monoFont: {
    fontFamily: "Roboto Mono, monospace",
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
          {data.map(i => (
            <ExpansionPanel
              key={i.id}
              TransitionProps={{ unmountOnExit: true }}
            >
              <ExpansionPanelSummary expandIcon={<ExpandMoreIcon />}>
                <Grid container spacing={1}>
                  <Grid item xs={12}>
                    <Typography variant="body1">{i.title}</Typography>
                  </Grid>

                  <Grid item xs={12}>
                    <Grid container direction="row">
                      <Grid item>
                        <LocationOnIcon fontSize="small" color="disabled" />
                      </Grid>
                      <Grid item>
                        <Typography variant="body2">{i.location}</Typography>
                      </Grid>
                    </Grid>
                  </Grid>

                  <Grid item xs={12}>
                    <Grid container direction="row" spacing={1}>
                      {[i.track, ...i.topics].map(topic => (
                        <Grid item>
                          <span
                            className={classes.dot}
                            style={{ backgroundColor: generateColor(topic) }}
                          />
                          &nbsp;
                          <Typography
                            variant="caption"
                            className={classes.monoFont}
                          >
                            {topic}
                          </Typography>
                        </Grid>
                      ))}
                    </Grid>
                  </Grid>
                </Grid>
              </ExpansionPanelSummary>
            </ExpansionPanel>
          ))}
        </Grid>
      </Grid>
    </Container>
  )
}

function generateColor(seed: string): string {
  let hash = 0
  for (let i = 0; i < seed.length; i++) {
    hash = seed.charCodeAt(i) + ((hash << 5) - hash)
    hash = hash & hash
  }
  const rgb = [0, 0, 0]
  for (let i = 0; i < 3; i++) {
    rgb[i] = (hash >> (i * 8)) & 255
  }
  return `rgb(${rgb[0]}, ${rgb[1]}, ${rgb[2]})`
}
