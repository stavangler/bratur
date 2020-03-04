import firebase from 'firebase'

export type Auth = {
  signIn: () => void
  signOut: () => Promise<void>
  user: firebase.User | null
  isAdmin: boolean | null
  isAuthed: boolean | null
}

