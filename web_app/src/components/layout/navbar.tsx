import React from 'react'
import { Link } from 'react-router-dom'
import SignedInLinks from './signed-in-links'
import SignedOutLinks from './signed-out-links'
import { useAuth } from '../auth/use-auth'

function Navbar () {
  const { user } = useAuth()

  return (
    <nav className="nav-wrapper grey darken-3">
      <div className="container">
        <Link to='/' className="brand-logo">Bratur!</Link>
        { user ? <SignedInLinks /> : <SignedOutLinks /> }
      </div>
    </nav>
  )
}

export default Navbar
