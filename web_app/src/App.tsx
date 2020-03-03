import React from 'react'
import {BrowserRouter, Route, Switch} from 'react-router-dom'
import Navbar from './components/layout/navbar'
import 'materialize-css/dist/css/materialize.min.css'
import 'materialize-css/dist/js/materialize.min.js'
import Dashboard from './components/dashboard/dashboard'
import TripDetails from './components/trips/trip-details'
import SignUp from './components/auth/sign-up'
import CreateTrip from './components/trips/create-trip'
import {ProvideAuth} from './components/auth/use-auth'
import {StoreProvider} from 'easy-peasy'
import store from './store'

function App() {
  return (
    <BrowserRouter>
      <ProvideAuth>
        <StoreProvider store={store}>
          <div className="App">
            <Navbar/>
            <Switch>
              <Route exact path='/' component={Dashboard}/>
              <Route path='/trip/:id' component={TripDetails}/>
              <Route path='/signup' component={SignUp}/>
              <Route path='/create' component={CreateTrip}/>
            </Switch>
          </div>
        </StoreProvider>
      </ProvideAuth>
    </BrowserRouter>
  )
}

export default App
