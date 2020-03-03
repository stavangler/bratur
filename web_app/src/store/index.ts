import {Store} from '../model'
import {createStore} from 'easy-peasy'
import trips from './trips'

const model: Store = {
  trips,
}

const store = createStore(model)

export default store
