import { action, thunk } from "easy-peasy";
import { Trip, Trips } from "../model/trip";
import firebase from "../firebase-config";

const trips: Trips = {
  items: [],
  setTrips: action((state, payload) => {
    state.items = payload;
  }),
  loading: false,
  error: false,
  setError: action((state, payload) => {
    state.error = payload;
  }),
  setLoading: action((state, payload) => {
    state.loading = payload;
  }),
  fetch: thunk(actions => {
    actions.setLoading(true);
    const unsubscribe = firebase
      .firestore()
      .collection("trips")
      .withConverter<Trip>({
        fromFirestore: snapshot => ({
          id: snapshot.id,
          name: snapshot.data().name,
          image: {
            attribution: snapshot.data().image.attribution,
            small: snapshot.data().image.small,
            medium: snapshot.data().image.medium,
            large: snapshot.data().image.large
          }
        }),
        toFirestore: (modelObject: Trip) => modelObject
      })
      .onSnapshot(
        snapshot => {
          actions.setLoading(false);
          actions.setError(false);
          actions.setTrips(snapshot.docs.map(doc => doc.data()));
        },
        error => {
          console.log(error);
          actions.setError(true);
        }
      );

    return () => unsubscribe();
  })
};

export default trips;
