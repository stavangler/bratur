import firebase from "../../firebase-config"
import { dataModel, DataModel } from "../../store/data-model"

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

export interface TripsModel extends DataModel<Trip, void> {}

const trips: TripsModel = {
  ...dataModel(() => firebase.firestore().collection("trips"), {
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
  }),
}

export default trips
