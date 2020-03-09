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
  const { fetch } = useStoreActions(actions => actions.agenda)
  const agenda = useStoreState(state => state.agenda)

  useEffect(() => {
    fetch(id)
  }, [fetch, id])

  return (
    <div className="card-content">
      <span className="card-title">
        Agenda ({agenda.items && agenda.items.length})
      </span>
      {agenda.items.map(i => (
        <div key={i.id}>{i.title}</div>
      ))}
      <p>
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Et labore
        quaerat quibusdam vel saepe, ab voluptate accusantium culpa nemo fuga
        earum? Soluta amet nobis officia sed neque fuga aperiam quia?
      </p>
    </div>
  )
}
