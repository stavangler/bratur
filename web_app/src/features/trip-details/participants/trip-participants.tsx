import React, { useEffect } from "react"
import { useStoreActions, useStoreState } from "../../../store/hooks"

interface ParamsProps {
  id: string
}

interface MatchProps {
  params: ParamsProps
}

interface TripProps {
  match: MatchProps
}

export default function TripAgenda(props: TripProps) {
  const { id } = props.match.params
  const fetch = useStoreActions(actions => actions.participants.fetch)
  const participants = useStoreState(state => state.participants)

  useEffect(() => {
    fetch(id)
  }, [fetch, id])

  return (
    <div className="card-content">
      <span className="card-title">
        Participants ({participants.items && participants.items.length})
      </span>
      {participants.items.map(p => (
        <div key={p.id}>{p.id}</div>
      ))}
      <p>
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Et labore
        quaerat quibusdam vel saepe, ab voluptate accusantium culpa nemo fuga
        earum? Soluta amet nobis officia sed neque fuga aperiam quia?
      </p>
    </div>
  )
}
