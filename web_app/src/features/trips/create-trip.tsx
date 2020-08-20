import React, {useState} from 'react'
import {Container, ExpansionPanel, ExpansionPanelSummary, Grid, Typography} from "@material-ui/core"
import ExpandMoreIcon from "@material-ui/icons/ExpandMore"
import LocationOnIcon from "@material-ui/icons/LocationOn"
import {makeStyles} from "@material-ui/core/styles"

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

function CreateTrip() {
  const classes = useStyles()
  const [title, setTitle] = useState('')
  const [description, setDescription] = useState('')

  function handleSubmit(/*e: FormEvent<HTMLFormElement>*/) {
    // e.preventDefault()
    console.log(title, description)
  }

  setTitle("temp")
  setDescription("temp")
  handleSubmit()

  return (
    <Container maxWidth="lg" className={classes.container}>
      <Grid container spacing={2}>
        <Grid item xs={12}>
          <Typography variant="h3">New trip</Typography>
        </Grid>

        <Grid item className={classes.expansionPanels}>
          <ExpansionPanel TransitionProps={{unmountOnExit: true}}>
            <ExpansionPanelSummary expandIcon={<ExpandMoreIcon/>}>
              <Grid container spacing={1}>

                <Grid item xs={12}>
                  <Typography variant="body1">title</Typography>
                </Grid>

                <Grid item xs={12}>
                  <Grid container direction="row">
                    <Grid item>
                      <LocationOnIcon fontSize="small" color="disabled"/>
                    </Grid>
                    <Grid item>
                      <Typography variant="body2">location</Typography>
                    </Grid>
                  </Grid>
                </Grid>

              </Grid>
            </ExpansionPanelSummary>
          </ExpansionPanel>
        </Grid>
      </Grid>
    </Container>
  )
}

export default CreateTrip
