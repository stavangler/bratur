import React from 'react'
import SignedInLinks from './signed-in-links'
import SignedOutLinks from './signed-out-links'
import {useAuth} from '../auth/use-auth'
import {AppBar, Toolbar, makeStyles, Typography} from '@material-ui/core'

const useStyles = makeStyles(theme => ({
    root: {
      display: 'flex',
    },
    toolbar: {
      paddingRight: 24,
    },
    toolbarIcon: {
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'flex-end',
      padding: '0 8px',
      ...theme.mixins.toolbar,
    },
    appBar: {
      zIndex: theme.zIndex.drawer + 1,
      transition: theme.transitions.create(['width', 'margin'], {
        easing: theme.transitions.easing.sharp,
        duration: theme.transitions.duration.leavingScreen,
      }),
      backgroundColor: theme.palette.grey["800"],
    },
    menuButton: {
      marginRight: 36,
    },
    menuButtonHidden: {
      display: 'none',
    },
    title: {
      flexGrow: 1,
    },
  }),
)

function Navbar() {
  const {user} = useAuth()
  const classes = useStyles()

  return (
    <AppBar position="fixed" className={classes.appBar}>
      <Toolbar className={classes.toolbar}>
        <Typography component="h1" variant="h6" color="inherit" noWrap className={classes.title}>
          Bratur!
        </Typography>
        {user ? <SignedInLinks/> : <SignedOutLinks/>}
      </Toolbar>
    </AppBar>
  )
}

export default Navbar
