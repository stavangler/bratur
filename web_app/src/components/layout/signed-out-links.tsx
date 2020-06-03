import React from "react"
import { useAuth } from "../auth/use-auth"
import { ReactRouterLink } from "../../features/react-router-link"
import { Button } from "@material-ui/core"

function SignedOutLinks() {
  const { signIn } = useAuth()

  return (
    <div style={{ display: "flex" }}>
      <Button component={ReactRouterLink} to="/signup" color="inherit">
        Signup
      </Button>
      <Button
        color="inherit"
        onClick={e => {
          e.preventDefault()
          signIn()
        }}
      >
        Login
      </Button>
    </div>
  )
}

export default SignedOutLinks
