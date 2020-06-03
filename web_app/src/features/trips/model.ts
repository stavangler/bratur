import firebase from "../../firebase-config"
import { dataModel, CollectionDataModel } from "../../store/data-model"

export interface Trip {
  id: string
  name: string
  image: {
    attribution: string
    small: string
    medium: string
    large: string
  }
}

export const tripConverter: firebase.firestore.FirestoreDataConverter<Trip> = {
  fromFirestore: snapshot => ({
    id: snapshot.id,
    name: snapshot.data().name,
    image: {
      attribution: snapshot.data().image.attribution,
      small: snapshot.data().image.small,
      medium: snapshot.data().image.medium,
      large: snapshot.data().image.large,
    },
  }),
  toFirestore: (modelObject: Trip) => modelObject,
}

export interface TripsModel extends CollectionDataModel<Trip> {}
const trips: TripsModel = {
  ...dataModel(() => firebase.firestore().collection("trips"), tripConverter),
}

export default trips
