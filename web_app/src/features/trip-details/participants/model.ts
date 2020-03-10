import firebase from "../../../firebase-config"
import { dataModel, DataModel } from "../../../store/data-model"

export interface Participant {
  id: string
  email: string
}

export interface Participants extends DataModel<Participant, string> {}

const participants: Participants = {
  ...dataModel(
    payload => firebase.firestore().collection(`trips/${payload}/people`),
    {
      fromFirestore: snapshot => ({
        id: snapshot.id,
        email: snapshot.data().email,
      }),
      toFirestore: (modelObject: Participant) => modelObject,
    }
  ),
}

export default participants
