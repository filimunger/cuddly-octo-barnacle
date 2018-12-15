import { BindInputs } from '../manager-userinput/userinput-module'
import { C, T_Panel, T_TypeButton } from '../manager-userinterface/userinterface-module'
import { TweenService, Workspace, Players, StarterGui } from 'rbx-services'
import { CreateNewEffect } from '../msc/helper-functions'

StarterGui.SetCore('TopbarEnabled', false)

let area = C('Area')
area.Frame.Name = 'TabMenuWorkspace'

let panel = C('Panel', area, { Visible: false, Size: new UDim2(0.8, 0, 0.8, 0), Position: new UDim2(0.1, 0, 0.1, 0), Transparency: 0.6, Color: new Color3() })

let scrolling = new ScrollingFrame(panel.Frame)
scrolling.CanvasSize = new UDim2()
scrolling.ScrollBarThickness = 0
scrolling.BackgroundTransparency = 1
scrolling.Size = new UDim2(1, 0, 1, 0)

coroutine.wrap(function() {
    for (let index = 0; index < 20; index++) {
        let circle = new ImageLabel(scrolling)
        circle.Size = new UDim2(0, 200, 0, 200)
        circle.Image = 'rbxgameasset://clean'
        circle.BackgroundTransparency = 1
        circle.ImageColor3 = BrickColor.random().Color
        circle.ImageTransparency = 0.4
        let newRandom = () => {
            return new UDim2(math.random(-10, 110) / 100, -50, math.random(-10, 110) / 100, -50)
        }
        circle.Position = newRandom()
        coroutine.wrap(function() {
            while (true) {
                wait(math.random(1, 10))
                let time = 20
                TweenService.Create(circle, new TweenInfo(time, Enum.EasingStyle.Sine), { Position: newRandom() }).Play()
                wait(time)
            }
        })()
    }
})()
let title = C('TypePanel', panel, { Text: 'ewkdlmaknfalkmzxklczoiloe', Size: new UDim2(0, 500, 0, 50) })
title.ConstrainSizeToTextBounds()
title.Position = new UDim2(0.5, -title.AbsoluteSize.X / 2, 0, -title.AbsoluteSize.Y)

let container = C('Container', panel, { Style: 'Grid', VAlignment: 'Top', CellSize: new UDim2(0.4, 0, 1, 0) })
let internalMenu = C('Panel', container, { Transparency: 0.5, TotalPadding: 15 })
let menu = C('Panel', container, { Transparency: 0.9, TotalPadding: 10 })
container = C('Container', menu, { VAlignment: 'Top', CellSize: new UDim2(1, 0, 0, 30), Padding: 5 })

export let AddMenuButton = (str: string = 'Undefined'): T_TypeButton => {
    let typeButton = C('TypeButton', container, { Text: str })
    return typeButton
}
export let AddInternalMenuButton = (str: string = 'Undefined'): T_Panel => {
    let menuButton = AddMenuButton(str)
    let panel = C('Panel', internalMenu, { Visible: false })
    let icon = C('Icon', menuButton, { Image: 'rbxgameasset://Images/directional-arrow', Name: 'InternalIcon', Visible: false, Size: new UDim2(0, 30, 0, 30), Position: new UDim2(0, 5, 0, 0), Color: Color3.fromRGB(0, 0, 0) })
    icon.ImageLabel.Rotation = 180
    menuButton.MouseClick.Connect(() => {
        for (let child of internalMenu.Frame.GetChildren()) {
            if (child instanceof Frame) {
                child.Visible = false
            }
        }
        for (let child of container.Folder.GetChildren()) {
            if (child instanceof Frame) {
                let icon = child.Frame.FindFirstChild('InternalIcon')
                if (icon) {
                    ;(icon as Frame).Visible = false
                }
            }
        }
        panel.Visible = true
        icon.Visible = true
    })
    return panel
}
export let AddVisifyingMenuButton = (str: string = 'Undefined', toAlter: Frame) => {
    let menuButton = AddMenuButton(str)
    let panel = C('Panel', menuButton, { Visible: false, Size: new UDim2(0, 30, 0, 30), Position: new UDim2(0, 15, 0, 0), TotalPadding: -15, Transparency: 1 })
    let icon = C('Icon', panel, { Image: 'rbxgameasset://Images/eye-open', Color: Color3.fromRGB(0, 0, 0) })
    toAlter.Visible = false
    menuButton.MouseClick.Connect(() => {
        let b = toAlter.Visible
        toAlter.Visible = !b
        icon.Visible = toAlter.Visible
    })
}

let distancePart = new Part(Workspace)
distancePart.Anchored = true
distancePart.CFrame = new CFrame(new Vector3(0, -50, 0))
distancePart.Transparency = 1
let box = CreateNewEffect('Box', Workspace) as Model
box.SetPrimaryPartCFrame(new CFrame(distancePart.Position))
BindInputs([
    Enum.KeyCode.Y,
    function() {
        let bool = panel.Visible
        panel.Visible = !bool
        if (bool) {
            let player = Players.LocalPlayer as Player
            if (player.Character) {
                // Note: ugly hack thanks to rbxtsc
                Workspace.CurrentCamera.CameraSubject = player.Character.WaitForChild('Humanoid') as BasePart
            }
        } else {
            Workspace.CurrentCamera.CameraSubject = distancePart
        }
    },
])
