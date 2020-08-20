import { AgendaItem, Speaker } from "./model"
import {
  Avatar,
  ExpansionPanel,
  ExpansionPanelDetails,
  ExpansionPanelSummary,
  Grid,
  List,
  ListItem,
  ListItemAvatar,
  ListItemText,
  Typography,
} from "@material-ui/core"
import ExpandMoreIcon from "@material-ui/icons/ExpandMore"
import LocationOnIcon from "@material-ui/icons/LocationOn"
import React, { useEffect, useState } from "react"
import { makeStyles } from "@material-ui/core/styles"
import moment from "moment"
import { knowitColors } from "../../../theme"

const useStyles = makeStyles({
  dot: {
    height: 12,
    width: 12,
    borderRadius: "50%",
    display: "inline-block",
  },
  monoFont: {
    fontFamily: "Roboto Mono, monospace",
  },
  time: {
    color: knowitColors.lollipop,
    marginTop: 6,
  },
})

interface Props {
  item: AgendaItem
}

export function AgendaEvent({ item }: Props) {
  const classes = useStyles()
  const [speakers, setSpeakers] = useState<Speaker[]>([])

  useEffect(() => {
    Promise.all(item.speakers.map(ref => ref.get())).then(speakers =>
      setSpeakers(
        speakers
          .map(snapshot => snapshot.data())
          .filter(data => !!data) as Speaker[],
      ),
    )
  }, [item.speakers])

  return (
    <ExpansionPanel TransitionProps={{ unmountOnExit: true }}>
      <ExpansionPanelSummary
        expandIcon={item.speakers.length ? <ExpandMoreIcon /> : undefined}
      >
        <Grid container>
          <Grid item xs={1} className={classes.time}>
            <Typography variant="button">
              {moment(item.startTime).format("LT")}
            </Typography>
          </Grid>

          <Grid item xs={11}>
            <Grid container spacing={1}>
              <Grid item xs={12}>
                <Typography variant="h6">{item.title}</Typography>
              </Grid>

              <Grid item xs={12}>
                <Grid container direction="row">
                  <Grid item>
                    <LocationOnIcon fontSize="small" color="disabled" />
                  </Grid>
                  <Grid item>
                    <Typography variant="body2">{item.location}</Typography>
                  </Grid>
                </Grid>
              </Grid>

              <Grid item xs={12}>
                <Grid container direction="row" spacing={1}>
                  {[item.track, ...item.topics].map(topic => (
                    <Grid item key={topic}>
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
          </Grid>
        </Grid>
      </ExpansionPanelSummary>

      {speakers.length && (
        <ExpansionPanelDetails>
          <Grid container spacing={2}>
            <Grid item xs={12}>
              <Typography variant="subtitle1">
                {moment(item.startTime).format("dddd, MMMM D, LT - ")}
                {moment(item.startTime)
                  .add(item.duration, "minutes")
                  .format("LT")}
              </Typography>
            </Grid>

            <Grid item xs={12}>
              <Typography variant="body2">{item.description}</Typography>
            </Grid>

            <Grid item xs={12}>
              <Typography variant="button">Speakers</Typography>

              <List>
                {speakers.map(speaker => (
                  <ListItem key={speaker.userId}>
                    <ListItemAvatar>
                      <Avatar src={speaker.photoUrl} alt={speaker.name} />
                    </ListItemAvatar>
                    <ListItemText>{speaker.name}</ListItemText>
                  </ListItem>
                ))}
              </List>
            </Grid>
          </Grid>
        </ExpansionPanelDetails>
      )}
    </ExpansionPanel>
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
