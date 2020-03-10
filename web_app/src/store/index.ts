import { createStore } from "easy-peasy"
import trips, { TripsModel } from "../features/trips/model"
import agenda, { AgendaModel } from "../features/trip-details/agenda/model"
import participants, {
  Participants,
} from "../features/trip-details/participants/model"
import tripInformation, {
  InformationModel,
} from "../features/trip-details/information/model"

export interface StoreModel {
  trips: TripsModel
  agenda: AgendaModel
  participants: Participants
  tripInformation: InformationModel
}

const model: StoreModel = {
  trips,
  agenda,
  participants,
  tripInformation,
}

const store = createStore(model)

export default store
