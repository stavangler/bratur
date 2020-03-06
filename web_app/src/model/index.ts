import {Trips} from './trip'
import {Agenda} from '../store/agenda'
import {Participants} from '../store/participants'

export interface Store {
  trips: Trips
  agenda: Agenda
  participants: Participants
}

