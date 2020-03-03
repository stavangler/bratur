import React, { FormEvent, useState } from 'react'

function CreateTrip () {
  const [title, setTitle] = useState('')
  const [description, setDescription] = useState('')

  function handleSubmit (e: FormEvent<HTMLFormElement>) {
    e.preventDefault()
    console.log(title, description)
  }

  return (
    <div className="container">
      <form className="white" onSubmit={handleSubmit}>
        <h5 className="grey-text text-darken-3">Create a New Trip</h5>
        <div className="input-field">
          <input type="text" id='title' onChange={(e) => setTitle(e.target.value)} />
          <label htmlFor="title">Destination</label>
        </div>
        <div className="input-field">
          <textarea id="content" className="materialize-textarea" onChange={(e) => setDescription(e.target.value)} />
          <label htmlFor="content">Description</label>
        </div>
        <div className="input-field">
          <button className="btn pink lighten-1">Create</button>
        </div>
      </form>
    </div>
  )
}

export default CreateTrip
