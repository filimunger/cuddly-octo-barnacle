import { Workspace } from 'rbx-services'

import { CallRemote } from '../manager-remote/manager-remote'
import { BindInputs } from '../manager-userinput/userinput-module'
import { C } from '../manager-userinterface/userinterface-module'

let camera = Workspace.CurrentCamera
camera.CameraType = Enum.CameraType.Scriptable
camera.FieldOfView = 20
camera.CFrame = new CFrame(new Vector3(0, 600, 0), new Vector3()).mul(CFrame.Angles(0, 0, math.pi / 2))
let sidePanelWidth = 0.23
let area = C('Area')
let panels = []
for (let multiplier of [0, 1]) {
    let panel = C('Panel', area, { Color: Color3.fromRGB(0, 0, 0), Position: new UDim2(multiplier + (multiplier === 1 ? -sidePanelWidth : 0), 0, 0, -36), Size: new UDim2(sidePanelWidth, 0, 1, 36) })

    panels.push(panel)
}

let peoplePanel = C('Panel', panels[1], { Transparency: 1, TotalPadding: 15 })
let peopleContainer = C('Container', peoplePanel, { CellSize: new UDim2(1, 0, 0, 250), Padding: 20 })
let addPerson = (dataFolder: Instance) => {
    let personPanel = C('TexturePanel', peopleContainer, {})
    let livesHeight = 60
    let livesPanel = C('Panel', personPanel, { Size: new UDim2(1, 0, 0, livesHeight), Transparency: 1 })
    let livesContainer = C('Container', livesPanel, { CellSize: new UDim2(0, livesHeight * 1.1, 0, livesHeight), HAlignment: 'Left' })
    let livesValue = dataFolder.WaitForChild('Lives') as NumberValue
    for (let index = 0; index < livesValue.Value; index++) {
        let singleLifePanel = C('Panel', livesContainer, { Transparency: 1, TotalPadding: 2 })
        print('singlelife')
        let singleLife = C('Icon', singleLifePanel, { Image: 'rbxassetid://2656578736', Color: Color3.fromRGB(255, 255, 255) })
        let singleLifeForegroundPanel = C('Panel', singleLife, { Transparency: 1, TotalPadding: 5 })
        let singleLifeForeground = C('Icon', singleLifeForegroundPanel, { Image: 'rbxassetid://2656578736', Color: Color3.fromRGB(255, 100, 100) })
    }
}
let friendlyData = Workspace.WaitForChild('FriendlyData')
friendlyData.GetChildren().forEach(addPerson)
friendlyData.ChildAdded.Connect(addPerson)

export = true

let callSteer = (x: number, y: number, steady?: boolean) => {
    CallRemote('CharacterSteer', x, y, steady)
}
let callFire = (bool: boolean) => {
    CallRemote('CharacterFire', bool)
}
BindInputs(
    [
        'Attack',
        () => {
            callFire(true)
        },
        () => {
            callFire(false)
        },
    ],
    ['Bomb', () => {}],
    [
        'Move_Steady',
        () => {
            callSteer(0, 0, true)
        },
        () => {
            callSteer(0, 0, false)
        },
    ],
    [
        'Move_Up',
        () => {
            callSteer(0, 1)
        },
        () => {
            callSteer(0, -1)
        },
    ],
    [
        'Move_Left',
        () => {
            callSteer(-1, 0)
        },
        () => {
            callSteer(1, 0)
        },
    ],
    [
        'Move_Down',
        () => {
            callSteer(0, -1)
        },
        () => {
            callSteer(0, 1)
        },
    ],
    [
        'Move_Right',
        () => {
            callSteer(1, 0)
        },
        () => {
            callSteer(-1, 0)
        },
    ],
)
