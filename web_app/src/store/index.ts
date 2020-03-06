import {Store} from '../model'
import {createStore} from 'easy-peasy'
import trips from './trips'
import agenda from './agenda'
import participants from './participants'

const model: Store = {
  trips,
  agenda,
  participants,
}

const store = createStore(model)

export default store
