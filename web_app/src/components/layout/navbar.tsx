import React from "react"
import SignedInLinks from "./signed-in-links"
import SignedOutLinks from "./signed-out-links"
import { useAuth } from "../auth/use-auth"
import {
  AppBar,
  IconButton,
  makeStyles,
  Toolbar,
  Typography,
} from "@material-ui/core"
import DashboardIcon from "@material-ui/icons/Dashboard"
import { ReactRouterLink } from "../../features/react-router-link"

const useStyles = makeStyles(theme => ({
  root: {
    display: "flex",
  },
  toolbar: {
    paddingRight: 24,
  },
  appBar: {
    zIndex: theme.zIndex.drawer + 1,
    transition: theme.transitions.create(["width", "margin"], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
  },
  title: {
    flexGrow: 1,
  },
}))

function Navbar() {
  const { user } = useAuth()
  const classes = useStyles()

  return (
    <AppBar position="fixed" className={classes.appBar}>
      <Toolbar className={classes.toolbar}>
        <IconButton component={ReactRouterLink} to="/">
          <DashboardIcon />
        </IconButton>
        <Typography
          component="h1"
          variant="h6"
          color="inherit"
          noWrap
          className={classes.title}
        >
          Bratur!
        </Typography>
        {user ? <SignedInLinks /> : <SignedOutLinks />}
      </Toolbar>
    </AppBar>
  )
}

export default Navbar
