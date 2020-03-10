import { action, Action, thunk, Thunk } from "easy-peasy"
import firebase from "firebase/app"

export interface DataModel<Data extends {}, SubscribePayload> {
  data: Data[]
  loading: boolean
  error: boolean
  subscribe: Thunk<
    DataModel<Data, SubscribePayload>,
    SubscribePayload,
    any,
    {},
    () => void
  >

  setLoading: Action<DataModel<Data, SubscribePayload>, boolean>
  setError: Action<DataModel<Data, SubscribePayload>, boolean>
  update: Action<DataModel<Data, SubscribePayload>, Data[]>
}

export const dataModel = <Data extends {}, SubscribePayload>(
  query: (payload: SubscribePayload) => firebase.firestore.Query,
  converter: firebase.firestore.FirestoreDataConverter<Data>
): DataModel<Data, SubscribePayload> => ({
  data: [],
  loading: true,
  error: false,

  subscribe: thunk((actions, payload) => {
    const unsubscribe = query(payload)
      .withConverter(converter)
      .onSnapshot(
        snapshot => {
          actions.setLoading(false)
          actions.setError(false)
          actions.update(snapshot.docs.map(doc => doc.data()))
        },
        error => {
          console.error(error)
          actions.setLoading(false)
          actions.setError(true)
        }
      )

    return () => unsubscribe()
  }),

  setLoading: action((state, payload) => {
    state.loading = payload
  }),
  setError: action((state, payload) => {
    state.error = payload
  }),
  update: action((state, items) => {
    state.data = items
  }),
})
