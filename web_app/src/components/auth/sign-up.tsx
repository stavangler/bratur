import React, { FormEvent, useState } from 'react'

function SignUp () {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [firstName, setFirstName] = useState('')
  const [lastName, setLastName] = useState('')

  function handleSubmit (e: FormEvent<HTMLFormElement>) {
    e.preventDefault()
    console.log(email, password, firstName, lastName)
  }

  return (
    <div className="container">
      <form className="white" onSubmit={handleSubmit}>
        <h5 className="grey-text text-darken-3">Sign Up</h5>
        <div className="input-field">
          <label htmlFor="email">Email</label>
          <input type="email" id='email' onChange={(e) => setEmail(e.target.value)}/>
        </div>
        <div className="input-field">
          <label htmlFor="password">Password</label>
          <input type="password" id='password' onChange={(e => setPassword(e.target.value))}/>
        </div>
        <div className="input-field">
          <label htmlFor="firstName">First Name</label>
          <input type="text" id='firstName' onChange={(e => setFirstName(e.target.value))}/>
        </div>
        <div className="input-field">
          <label htmlFor="lastName">Last Name</label>
          <input type="text" id='lastName' onChange={(e => setLastName(e.target.value))}/>
        </div>
        <div className="input-field">
          <button className="btn pink lighten-1 z-depth-0">Sign Up</button>
        </div>
      </form>
    </div>
  )
}

export default SignUp
