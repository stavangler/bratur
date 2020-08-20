import { action, Action, thunk, Thunk } from "easy-peasy"
import firebase from "firebase/app"

export interface CollectionDataModel<Data extends {}, SubscribePayload = void>
  extends DataModel<
    Data,
    SubscribePayload,
    firebase.firestore.CollectionReference
  > {}
export interface DocumentDataModel<Data extends {}, SubscribePayload = void>
  extends DataModel<
    Data,
    SubscribePayload,
    firebase.firestore.DocumentReference
  > {}

interface DataModel<
  Data extends {},
  SubscribePayload,
  DataKind extends
    | firebase.firestore.CollectionReference
    | firebase.firestore.DocumentReference
> {
  data: Data[]
  loading: boolean
  error: boolean
  subscribe: Thunk<
    DataModel<Data, SubscribePayload, DataKind>,
    SubscribePayload,
    any,
    {},
    () => void
  >

  setLoading: Action<DataModel<Data, SubscribePayload, DataKind>, boolean>
  setError: Action<DataModel<Data, SubscribePayload, DataKind>, boolean>
  update: Action<DataModel<Data, SubscribePayload, DataKind>, Data[]>
}

export const dataModel = <Data extends {}, SubscribePayload>(
  query: (
    payload: SubscribePayload
  ) =>
    | firebase.firestore.CollectionReference
    | firebase.firestore.DocumentReference,
  converter: firebase.firestore.FirestoreDataConverter<Data>,
): DataModel<Data, SubscribePayload, ReturnType<typeof query>> => ({
  data: [],
  loading: true,
  error: false,

  subscribe: thunk((actions, payload) => {
    const queryOrReference = query(payload)
    if (queryOrReference instanceof firebase.firestore.CollectionReference) {
      const unsubscribe = queryOrReference.withConverter(converter).onSnapshot(
        snapshot => {
          actions.setLoading(false)
          actions.setError(false)
          actions.update(snapshot.docs.map(doc => doc.data()))
        },
        error => {
          console.error(error)
          actions.setLoading(false)
          actions.setError(true)
        },
      )

      return () => unsubscribe()
    } else {
      const unsubscribe = queryOrReference.withConverter(converter).onSnapshot(
        snapshot => {
          actions.setLoading(false)
          actions.setError(false)
          const data = snapshot.data()
          actions.update(data ? [data] : [])
        },
        error => {
          console.error(error)
          actions.setLoading(false)
          actions.setError(true)
        },
      )

      return () => unsubscribe()
    }
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
