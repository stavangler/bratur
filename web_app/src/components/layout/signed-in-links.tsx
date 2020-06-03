import React from "react"
import { useAuth } from "../auth/use-auth"
import { ReactRouterLink } from "../../features/react-router-link"
import { Avatar, Button, makeStyles } from "@material-ui/core"

const useStyles = makeStyles(theme => ({
  root: {
    display: "flex",
  },
  menuButton: {
    marginRight: 36,
  },
}))

function SignedInLinks() {
  const { user, signOut } = useAuth()
  const classes = useStyles()
  return (
    <div className={classes.root}>
      <Button
        className={classes.menuButton}
        component={ReactRouterLink}
        to="/create"
        color="inherit"
      >
        New trip
      </Button>
      <Button
        className={classes.menuButton}
        color="inherit"
        onClick={e => {
          e.preventDefault()
          signOut()
        }}
      >
        Log out
      </Button>
      <Avatar
        title={user?.displayName?.toString()}
        src={user?.photoURL?.toString()}
      />
    </div>
  )
}

export default SignedInLinks
