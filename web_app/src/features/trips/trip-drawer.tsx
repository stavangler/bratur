import React from "react"
import { ReactRouterLink } from "../react-router-link"
import Drawer from "@material-ui/core/Drawer"
import { makeStyles, List } from "@material-ui/core"
import ListItem from "@material-ui/core/ListItem"
import ListItemIcon from "@material-ui/core/ListItemIcon"
import ListItemText from "@material-ui/core/ListItemText"
import ViewAgendaIcon from "@material-ui/icons/ViewAgenda"
import PeopleIcon from "@material-ui/icons/People"
import LayersIcon from "@material-ui/icons/Layers"
import { useLocation } from "react-router-dom"

const drawerWidth = 240

const useStyles = makeStyles(theme => ({
  root: {
    display: "flex",
  },
  drawerPaper: {
    position: "relative",
    whiteSpace: "nowrap",
    width: drawerWidth,
    transition: theme.transitions.create("width", {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  },
  appBarSpacer: theme.mixins.toolbar,
  content: {
    flexGrow: 1,
    height: "100vh",
    overflow: "auto",
  },
  container: {
    paddingTop: theme.spacing(4),
    paddingBottom: theme.spacing(4),
  },
  paper: {
    padding: theme.spacing(2),
    display: "flex",
    overflow: "auto",
    flexDirection: "column",
  },
  fixedHeight: {
    height: 240,
  },
}))

interface DrawerProps {
  id: string
}

function TripDrawer(props: DrawerProps) {
  const { id } = props
  const classes = useStyles()
  const location = useLocation()

  return (
    <Drawer
      variant="permanent"
      classes={{
        paper: classes.drawerPaper,
      }}
      open={true}
    >
      <List>
        <ListItem
          button
          component={ReactRouterLink}
          to={`/trip/${id}`}
          selected={location.pathname === `/trip/${id}`}
        >
          <ListItemIcon>
            <LayersIcon />
          </ListItemIcon>
          <ListItemText primary="Information" />
        </ListItem>
        <ListItem
          button
          component={ReactRouterLink}
          to={`/trip/${id}/agenda`}
          selected={location.pathname === `/trip/${id}/agenda`}
        >
          <ListItemIcon>
            <ViewAgendaIcon />
          </ListItemIcon>
          <ListItemText primary="Agenda" />
        </ListItem>
        <ListItem
          button
          component={ReactRouterLink}
          to={`/trip/${id}/participants`}
          selected={location.pathname === `/trip/${id}/participants`}
        >
          <ListItemIcon>
            <PeopleIcon />
          </ListItemIcon>
          <ListItemText primary="Participants" />
        </ListItem>
      </List>
    </Drawer>
  )
}

export default TripDrawer
