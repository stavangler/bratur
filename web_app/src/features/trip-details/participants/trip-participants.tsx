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
  const subscribe = useStoreActions(actions => actions.participants.subscribe)
  const data = useStoreState(state => state.participants.data)

  useEffect(() => {
    return subscribe(id)
  }, [subscribe, id])

  return (
    <div className="card-content">
      <span className="card-title">Participants ({data && data.length})</span>
      {data.map(p => (
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
