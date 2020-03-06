import React from 'react'
import {ReactRouterLink} from '../react-router-link'
import Drawer from '@material-ui/core/Drawer'
import {makeStyles} from '@material-ui/core'
import ListItem from '@material-ui/core/ListItem'
import ListItemIcon from '@material-ui/core/ListItemIcon'
import ListItemText from '@material-ui/core/ListItemText'
import DashboardIcon from '@material-ui/icons/Dashboard'
import ViewAgendaIcon from '@material-ui/icons/ViewAgenda'
import PeopleIcon from '@material-ui/icons/People'
import LayersIcon from '@material-ui/icons/Layers'

const drawerWidth = 240

const useStyles = makeStyles(theme => ({
    root: {
      display: 'flex',
    },
    drawerPaper: {
      position: 'relative',
      whiteSpace: 'nowrap',
      width: drawerWidth,
      transition: theme.transitions.create('width', {
        easing: theme.transitions.easing.sharp,
        duration: theme.transitions.duration.enteringScreen,
      }),
    },
    appBarSpacer: theme.mixins.toolbar,
    content: {
      flexGrow: 1,
      height: '100vh',
      overflow: 'auto',
    },
    container: {
      paddingTop: theme.spacing(4),
      paddingBottom: theme.spacing(4),
    },
    paper: {
      padding: theme.spacing(2),
      display: 'flex',
      overflow: 'auto',
      flexDirection: 'column',
    },
    fixedHeight: {
      height: 240,
    },
  }),
)

interface DrawerProps {
  id: string
}

function TripDrawer(props: DrawerProps) {
  const {id} = props
  const classes = useStyles()
  return (
    <Drawer
      variant="permanent"
      classes={{
        paper: classes.drawerPaper,
      }}
      open={true}
    >
      <div>
        <ListItem button component={ReactRouterLink} to="/">
          <ListItemIcon>
            <DashboardIcon/>
          </ListItemIcon>
          <ListItemText primary="All trips"/>
        </ListItem>
        <ListItem button component={ReactRouterLink} to={'/trip/' + id}>
          <ListItemIcon>
            <LayersIcon/>
          </ListItemIcon>
          <ListItemText primary="Information"/>
        </ListItem>
        <ListItem button component={ReactRouterLink} to={'/trip/' + id + '/agenda'}>
          <ListItemIcon>
            <ViewAgendaIcon/>
          </ListItemIcon>
          <ListItemText primary="Agenda"/>
        </ListItem>
        <ListItem button component={ReactRouterLink} to={'/trip/' + id + '/participants'}>
          <ListItemIcon>
            <PeopleIcon/>
          </ListItemIcon>
          <ListItemText primary="Participants"/>
        </ListItem>
      </div>
    </Drawer>
  )
}

export default TripDrawer
