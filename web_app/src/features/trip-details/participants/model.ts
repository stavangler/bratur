import { action, Action, thunk, Thunk } from "easy-peasy"
import firebase from "../../../firebase-config"

export interface Participant {
  id: string
  email: string
}

export interface Participants {
  tripId: string
  setTripId: Action<Participants, string>
  items: Participant[]
  fetch: Thunk<Participants, string>
  setItems: Action<Participants, Participant[]>
  loading: boolean | false
  error: boolean | false
  setError: Action<Participants, boolean>
  setLoading: Action<Participants, boolean>
}

const participants: Participants = {
  tripId: "",
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
      .collection(`trips/${payload}/people`)
      .withConverter({
        fromFirestore: snapshot => ({
          id: snapshot.id,
          email: snapshot.data().email,
        }),
        toFirestore: (modelObject: Participant) => modelObject,
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
        }
      )

    return () => unsubscribe()
  }),
}

export default participants
