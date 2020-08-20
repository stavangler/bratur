import { dataModel, DocumentDataModel } from "../../../store/data-model"
import { Trip, tripConverter } from "../../trips/model"
import firebase from "firebase/app"

export interface InformationModel extends DocumentDataModel<Trip, string> {}

const tripInformation: InformationModel = {
  ...dataModel(
    payload =>
      firebase
        .firestore()
        .collection("trips")
        .doc(payload),
    tripConverter,
  ),
}

export default tripInformation
