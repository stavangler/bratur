import React, { createContext, useContext, useEffect, useState } from 'react'
import firebase from '../../firebase-config'

firebase.auth().useDeviceLanguage()

type Auth = {
  signIn: () => void
  signOut: () => Promise<void>
  user: firebase.User | null
  admin: boolean | null
}

const authContext = createContext<Auth | null>(null)

export const useAuth = () => {
  return (
    useContext(authContext) || {
      signIn: () => undefined,
      signOut: () => undefined,
      user: firebase.auth().currentUser,
      admin: null,
    }
  )
}

function useProvideAuth (): Auth {
  const [user, setUser] = useState<firebase.User | null>(null)
  const [admin, setAdmin] = useState<boolean | null>(null)

  const signIn = () => {
    firebase
      .auth()
      .signInWithRedirect(new firebase.auth.GoogleAuthProvider())
      .then(() => {
        console.log('signed in')
      })
  }

  const signOut = () => {
    return firebase
      .auth()
      .signOut()
      .then(() => {
        console.log('signed out')
        setUser(null)
      })
  }

  useEffect(() => {
    firebase
      .auth()
      .getRedirectResult()
      .then()
      .catch(error => {
        console.error(error)
        signOut().then()
      })

    const unsubscribe = firebase.auth().onAuthStateChanged(user => {
      // Remove previous listener.
      // On user login add new listener.
      if (user) {
        setUser(user)
        setAdmin(true)
      }
    })

    return () => {
      unsubscribe()
    }
  }, [])

  useEffect(() => {
    if (admin === false) {
      signOut().then(() => {
        setUser(null)
        setAdmin(null)
      })
    }
  }, [admin])

  return {
    user,
    admin,
    signIn,
    signOut,
  }
}

export const ProvideAuth = ({ children }: { children: React.ReactElement }) => {
  const auth = useProvideAuth()

  return <authContext.Provider value={auth}>{children}</authContext.Provider>
}
