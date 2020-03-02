import React, { useEffect } from 'react'
import * as firebase from 'firebase/app'
// eslint-disable-next-line no-unused-vars
import { Trip } from '../../model/trip'

export function useTrips () {
  const [error, setError] = React.useState(false)
  const [loading, setLoading] = React.useState(true)
  const [trips, setTrips] = React.useState<Trip[]>([])

  useEffect(() => {
    const unsubscribe = firebase
      .firestore()
      .collection('trips')
      .withConverter({
        fromFirestore: snapshot => ({
          id: snapshot.id,
          name: snapshot.data().name,
        }),
        toFirestore: (modelObject: Trip) => modelObject,
      })
      .onSnapshot(
        snapshot => {
          setLoading(false)
          setError(false)
          setTrips(snapshot.docs.map(doc => doc.data()))
        },
        error => {
          console.log(error)
          setError(true)
        },
      )

    return () => unsubscribe()
  }, [])

  return {
    error,
    loading,
    trips,
  }
}
