import { UserInterfaceRemotes } from '../manager-userinterface/_server-userinterface'

// Gets imports

let ManagedRemotes = {
    Cresresr: () => {},
    ...UserInterfaceRemotes,
}

export type T_ManagedRemotes = typeof ManagedRemotes
export let _ = undefined
