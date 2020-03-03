import React from 'react'
import { NavLink } from 'react-router-dom'
import { useAuth } from '../auth/use-auth'

function SignedInLinks () {
  const { user, signOut } = useAuth()
  return (
    <div>
      <ul className="right">
        <li><NavLink to='/create'>New trip</NavLink></li>
        <li><a href="/#" onClick={(e) => { e.preventDefault(); signOut() }}>Log out</a></li>
        <li><NavLink to='/' className="btn btn-floating pink lighten-1">
          <img className="btn btn-floating pink lighten-1" src={user?.photoURL?.toString()} alt="" />
        </NavLink></li>
      </ul>
    </div>
  )
}

export default SignedInLinks
