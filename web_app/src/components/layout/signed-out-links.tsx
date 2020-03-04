import React from 'react'
import { NavLink } from 'react-router-dom'
import { useAuth } from '../auth/use-auth'

function SignedOutLinks () {
  const { signIn } = useAuth()

  return (
    <div>
      <ul className="right">
        <li><NavLink to='/signup'>Signup</NavLink></li>
        <li><a href="/#" onClick={(e) => { e.preventDefault(); signIn() }}>Login</a></li>
      </ul>
    </div>
  )
}

export default SignedOutLinks
