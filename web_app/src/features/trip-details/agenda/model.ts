import firebase from "../../../firebase-config"
import { dataModel, CollectionDataModel } from "../../../store/data-model"

export interface Speaker {
  userId: string
  name: string
  photoUrl: string
}

export interface AgendaItem {
  id: string
  title: string
  description: string
  location: string
  speakers: firebase.firestore.DocumentReference<Speaker>[]
  topics: string[]
  track: string
  startTime: Date
  duration: number
}

export interface AgendaModel extends CollectionDataModel<AgendaItem, string> {}

const agenda: AgendaModel = {
  ...dataModel(
    payload => firebase.firestore().collection(`trips/${payload}/agenda`),
    {
      fromFirestore: snapshot => ({
        id: snapshot.id,
        title: snapshot.data().title,
        description: snapshot.data().description,
        location: snapshot.data().location,
        track: snapshot.data().track,
        speakers: (snapshot.data()
          .speakers as firebase.firestore.DocumentReference[]).map(ref =>
          ref.withConverter<Speaker>({
            fromFirestore: snapshot => ({
              userId: snapshot.id,
              name: snapshot.data().name,
              photoUrl: snapshot.data().photoUrl,
            }),
            toFirestore: modelObject => modelObject,
          }),
        ),
        topics: snapshot.data().topics,
        startTime: (snapshot.data()
          .startTime as firebase.firestore.Timestamp).toDate(),
        duration: snapshot.data().duration,
      }),
      toFirestore: (modelObject: AgendaItem) => modelObject,
    },
  ),
}

export default agenda
