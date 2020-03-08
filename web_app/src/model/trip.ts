import { Action, Thunk } from "easy-peasy";

export interface Trip {
  id: string;
  name: string;
  image: {
    attribution: string;
    small: string;
    medium: string;
    large: string;
  };
}

export interface Trips {
  items: Trip[];
  fetch: Thunk<Trips, void, any, {}, () => void>;
  setTrips: Action<Trips, Trip[]>;
  loading: boolean | false;
  error: boolean | false;
  setError: Action<Trips, boolean>;
  setLoading: Action<Trips, boolean>;
}
