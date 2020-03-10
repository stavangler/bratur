import firebase from "../../../firebase-config"
import { dataModel, DataModel } from "../../../store/data-model"

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

export interface AgendaModel extends DataModel<AgendaItem, string> {}

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
        speakers: snapshot.data().speakers,
        topics: snapshot.data().topics,
      }),
      toFirestore: (modelObject: AgendaItem) => modelObject,
    }
  ),
}

export default agenda
