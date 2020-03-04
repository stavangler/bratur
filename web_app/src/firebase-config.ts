import firebase from 'firebase/app'
import 'firebase/firestore'
import 'firebase/auth'

const config = {
  apiKey: 'AIzaSyD5zymGUPPi-82S0wzgdZT6PlB-LLiUSFo',
  authDomain: 'bratur.firebaseapp.com',
  databaseURL: 'https://bratur.firebaseio.com',
  projectId: 'bratur',
  storageBucket: 'bratur.appspot.com',
  messagingSenderId: '93596352093',
  appId: '1:93596352093:web:70144715b7f17a227ad7b4',
  measurementId: 'G-T32MM4GJ1W',
}

firebase.initializeApp(config)
firebase.firestore()
  .enablePersistence()
  .catch(function (err) {
    if (err.code === 'failed-precondition') {
      console.log(
        'Multiple tabs where open. Offline caching is only supported on one tab at a time.',
      )
    } else if (err.code === 'unimplemented') {
      console.log("The current browser doesn't support offline caching.")
    }
  })

export default firebase
