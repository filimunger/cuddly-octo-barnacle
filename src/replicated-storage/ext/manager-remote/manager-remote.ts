import { ReplicatedStorage, RunService, Players } from 'rbx-services'
import { T_ManagedRemotes } from './remote-hub'

type T_ManagedRemotesIndex = keyof T_ManagedRemotes
type T_ArgumentTypes<F extends Function> = F extends (...args: infer A) => any ? A : never
type T_AnyRemote = RemoteEvent | RemoteFunction | BindableEvent | BindableFunction

export function BindFunctionToRemote<T extends T_ManagedRemotesIndex>(remoteName: T, remoteFunction: (...args: any) => any): RBXScriptConnection | string | void {
    let a: T_AnyRemote | undefined = ReplicatedStorage.Events.FindFirstChild(remoteName as any)
    if (a) {
        let isServer = RunService.IsServer()
        if (a instanceof RemoteEvent) {
            return isServer ? a.OnServerEvent.Connect(remoteFunction) : a.OnClientEvent.Connect(remoteFunction)
        } else if (a instanceof RemoteFunction) {
            if (isServer) {
                a.OnServerInvoke = remoteFunction
            } else {
                a.OnClientInvoke = remoteFunction
            }
            return isServer ? 'OnServerInvoke' : 'OnClientInvoke'
        }
    } else {
        warn('Failed to bind function to remote |', remoteName)
    }
}

export function EngageRemoteObject(object: { [key: string]: any }) {
    let events = ReplicatedStorage.WaitForChild('Events') as Folder
    for (let index in object) {
        let fn = object[index]
        let remote = new RemoteEvent(events)
        remote.Name = index
        BindFunctionToRemote(index as any, fn)
    }
}

export function CallRemote<T extends T_ManagedRemotesIndex>(remoteName: T, ...args: T_ArgumentTypes<T_ManagedRemotes[T]>): ReturnType<T_ManagedRemotes[T]> | undefined {
    let newArgs = []
    for (let index in args) {
        newArgs.push(args[index])
    }
    let a: T_AnyRemote | undefined = ReplicatedStorage.Events.FindFirstChild(remoteName as any)
    if (a) {
        let isServer = RunService.IsServer()
        if (a instanceof RemoteEvent) {
            if (isServer) {
                a.FireAllClients(...newArgs)
            } else {
                a.FireServer(...newArgs)
            }
        } else if (a instanceof RemoteFunction) {
            if (isServer) {
                let players = Players.GetPlayers()
                for (let player of players) {
                    a.InvokeClient(player, ...newArgs)
                }
            } else {
                return a.InvokeServer(...newArgs) as any
            }
        }
    } else {
        warn('Could not locate remote |', remoteName)
    }
}
