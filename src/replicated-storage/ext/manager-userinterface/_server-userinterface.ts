import { StarterGui } from 'rbx-services'
import { EngageRemoteObject } from '../manager-remote/manager-remote'
let screenGui = new ScreenGui(StarterGui)
screenGui.ResetOnSpawn = false

export let UserInterfaceRemotes = {
    ChangeValue: (player: Player | undefined, value: any, newVariable: any) => {
        value.Value = newVariable
    },
}
EngageRemoteObject(UserInterfaceRemotes)
