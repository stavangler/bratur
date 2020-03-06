import { Action, Thunk } from 'easy-peasy'
import {Agenda} from "../store/agenda";

export interface Trip {
  id: string,
  name: string
}

export interface Trips {
  items: Trip[]
  fetch: Thunk<Trips>
  setTrips: Action<Trips, Trip[]>
  loading: boolean | false
  error: boolean | false
  setError: Action<Trips, boolean>
  setLoading: Action<Trips, boolean>
}

