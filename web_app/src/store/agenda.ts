import {action, Action, thunk, Thunk} from 'easy-peasy'
import firebase from '../firebase-config'

export interface Speaker {
  id: number
  email: string
}

export interface Topic {
  id: number
  topic: string
}

export interface AgendaItem {
  id: string
  title: string
  description: string
  location: string
  speakers: Speaker[]
  topics: Topic[]
  track: string
}

export interface Agenda {
  tripId: string
  setTripId: Action<Agenda, string>
  items: AgendaItem[]
  fetch: Thunk<Agenda, string>
  setItems: Action<Agenda, AgendaItem[]>
  loading: boolean | false
  error: boolean | false
  setError: Action<Agenda, boolean>
  setLoading: Action<Agenda, boolean>
}

const agenda: Agenda = {
  tripId: '',
  setTripId: action((state, payload) => {
    state.tripId = payload
  }),
  items: [],
  setItems: action((state, payload) => {
    state.items = payload
  }),
  loading: false,
  error: false,
  setError: action((state, payload) => {
    state.error = payload
  }),
  setLoading: action((state, payload) => {
    state.loading = payload
  }),
  fetch: thunk(async (actions, payload) => {
    actions.setLoading(true)
    const unsubscribe = firebase
      .firestore()
      .collection(`trips/${payload}/agenda`)
      .withConverter({
        fromFirestore: snapshot => ({
          id: snapshot.id,
          title: snapshot.data().title,
          description: snapshot.data().description,
          location: snapshot.data().location,
          track: snapshot.data().track,
          speakers: snapshot.data().speakers,
          topics: snapshot.data().topics,
        }),
        toFirestore: (modelObject: AgendaItem) => modelObject,
      })
      .onSnapshot(
        snapshot => {
          actions.setLoading(false)
          actions.setError(false)
          actions.setTripId(payload)
          actions.setItems(snapshot.docs.map(doc => doc.data()))
        },
        error => {
          console.log(error)
          actions.setError(true)
        },
      )

    return () => unsubscribe()
  }),
}

export default agenda
