import React from "react"
import { BrowserRouter, Route, Switch } from "react-router-dom"
import CssBaseline from "@material-ui/core/CssBaseline"
import Navbar from "./components/layout/navbar"
import Dashboard from "./features/dashboard/dashboard"
import TripDetails from "./features/trip-details/trip-details"
import SignUp from "./components/auth/sign-up"
import CreateTrip from "./features/trips/create-trip"
import { ProvideAuth } from "./components/auth/use-auth"
import { StoreProvider } from "easy-peasy"
import store from "./store"
import { makeStyles } from "@material-ui/core"

const useStyles = makeStyles(theme => ({
  root: {
    display: "flex",
  },
  appBarSpacer: theme.mixins.toolbar,
}))

function App() {
  const classes = useStyles()

  return (
    <>
      <CssBaseline />
      <BrowserRouter>
        <ProvideAuth>
          <StoreProvider store={store}>
            <div className="App">
              <Navbar />
              <div className={classes.appBarSpacer} />
              <Switch>
                <Route exact path="/" component={Dashboard} />
                <Route path="/trip/:id" component={TripDetails} />
                <Route path="/signup" component={SignUp} />
                <Route path="/create" component={CreateTrip} />
              </Switch>
            </div>
          </StoreProvider>
        </ProvideAuth>
      </BrowserRouter>
    </>
  )
}

export default App
