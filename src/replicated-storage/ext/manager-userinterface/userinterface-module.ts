import { CollectionService, Players, TweenService } from 'rbx-services'

import { CustomCheckTypeOf, EnumString, ObjectArrayLength } from '../msc/helper-functions'
import { CallRemote } from '../manager-remote/manager-remote'
import { BindInputs } from '../manager-userinput/userinput-module'
import { PaletteInterfaceRemarks, VisualSettings } from './visual-settings-module'

export type T_Panel = UserInterfaceTypes.Panel
export type T_TextureButton = UserInterfaceTypes.TextureButton
export type T_TypeButton = UserInterfaceTypes.TypeButton
export type T_Container = UserInterfaceTypes.Container

export let GameVisualSettings = new VisualSettings()
let texttipContainer: any
let propertyMenuArea: any
type T_InterfaceComponent = (object: UserInterfaceTypes.Primitive | UserInterfaceTypes.Container, ...args: any[]) => (() => void) | undefined
let AvailableInterfaceComponents: { [index in 'TextCenterUnderline' | 'ButtonReaction_Default' | 'ButtonReaction_Slider' | 'ButtonReaction_TextTip']: T_InterfaceComponent }

export namespace UserInterfaceTypes {
    export class Primitive {
        MainFrame: Frame
        EndInterfaceComponents: (() => void)[] = []
        set ZIndex(prop: number) {
            let oldZIndex = this.MainFrame.ZIndex
            this.MainFrame.ZIndex = prop
            let difference = this.MainFrame.ZIndex - oldZIndex
            let recurse: any
            recurse = (object: Instance) => {
                for (let element of object.GetChildren()) {
                    if (element instanceof GuiObject) {
                        element.ZIndex = element.ZIndex + difference
                    }
                    recurse(element)
                }
            }
            recurse(this.MainFrame)
        }
        set Parent(parent: Instance | undefined) {
            this.MainFrame.Parent = parent
            if (parent) {
                let newParent = parent.IsA('GuiObject') && !parent.IsA('ScrollingFrame') ? parent : parent.Parent && parent.Parent.IsA('GuiObject') && !parent.Parent.IsA('ScrollingFrame') ? parent.Parent : parent.Parent && parent.Parent.Parent && parent.Parent.Parent.IsA('GuiObject') && !parent.Parent.Parent.IsA('ScrollingFrame') ? parent.Parent.Parent : undefined
                if (newParent) {
                    this.ZIndex = newParent.ZIndex + 1
                }
            }
        }
        get Parent() {
            return this.MainFrame.Parent
        }
        set Name(prop: string) {
            this.MainFrame.Name = prop
        }
        set Size(prop: UDim2) {
            this.MainFrame.Size = prop
        }
        get Size() {
            return this.MainFrame.Size
        }
        set Position(prop: UDim2) {
            this.MainFrame.Position = prop
        }
        get Position() {
            return this.MainFrame.Position
        }
        set Visible(prop: boolean) {
            this.MainFrame.Visible = prop
        }
        get Visible() {
            return this.MainFrame.Visible
        }
        get AbsoluteSize() {
            return this.MainFrame.AbsoluteSize
        }
        get AbsolutePosition() {
            return this.MainFrame.AbsolutePosition
        }
        Destroy() {
            this.MainFrame.Destroy()
        }
        constructor() {
            this.MainFrame = new Frame()
            this.MainFrame.BackgroundTransparency = 1
            this.Size = new UDim2(1, 0, 1, 0)
        }
    }

    export class Icon extends Primitive {
        ImageLabel: ImageLabel
        set Color(prop: Color3) {
            this.ImageLabel.ImageColor3 = prop
        }
        get Color() {
            return this.ImageLabel.BackgroundColor3
        }
        set Image(prop: string) {
            this.ImageLabel.Image = prop
        }
        set ImageTransparency(prop: number) {
            this.ImageLabel.ImageTransparency = prop
        }
        constructor() {
            super()
            this.ImageLabel = new ImageLabel(this.MainFrame)
            this.ImageLabel.ZIndex = this.MainFrame.ZIndex + 1 // essential
            this.ImageLabel.Size = new UDim2(1, 0, 1, 0) // essential
            this.ImageLabel.BackgroundTransparency = 1 // essential
            this.Image = GameVisualSettings.IconImage
        }
    }

    export class ViewportPanel extends Primitive {
        ViewportFrame: ViewportFrame
        set Camera(prop: Camera) {
            this.ViewportFrame.CurrentCamera = prop
        }
        get Camera() {
            return this.ViewportFrame.CurrentCamera
        }
        SetContents(contents: Instance) {
            this.ViewportFrame.ClearAllChildren()
            contents.Parent = this.ViewportFrame
        }
        constructor() {
            super()
            this.ViewportFrame = new ViewportFrame(this.MainFrame)
            this.ViewportFrame.ZIndex = this.MainFrame.ZIndex + 1 // essential
            this.ViewportFrame.Size = new UDim2(1, 0, 1, 0) // essential
            this.ViewportFrame.BackgroundTransparency = 1 // essential
        }
    }

    export class Panel extends Primitive {
        Frame: Frame
        CheckColorAndLinkIfNecessary(prop: Color3, alt: GuiObject = this.Frame) {
            for (let collectionName of CollectionService.GetTags(alt)) {
                CollectionService.RemoveTag(alt, collectionName)
            }
            for (let collectionName in PaletteInterfaceRemarks) {
                let visualSettingsIndex = (PaletteInterfaceRemarks as any)[collectionName]
                let compareColor = (GameVisualSettings as any)[visualSettingsIndex]
                if (compareColor === prop) {
                    CollectionService.AddTag(alt, collectionName)
                    return
                }
            }
        }
        set TotalPadding(padding: number) {
            this.Frame.Size = new UDim2(1, -padding * 2, 1, -padding * 2)
            this.Frame.Position = new UDim2(0, padding, 0, padding)
        }
        set Transparency(prop: number) {
            this.Frame.BackgroundTransparency = prop
        }
        set Color(prop: Color3) {
            this.Frame.BackgroundColor3 = prop
            this.CheckColorAndLinkIfNecessary(prop)
        }
        get Color() {
            return this.Frame.BackgroundColor3
        }
        AddInterfaceComponent<T extends keyof typeof AvailableInterfaceComponents>(interfaceComponentIndex: T | T_InterfaceComponent, id: string, ...args: any[]) {
            let fn = typeof interfaceComponentIndex === 'string' ? AvailableInterfaceComponents[interfaceComponentIndex] : (interfaceComponentIndex as T_InterfaceComponent)
            let endInterfaceFunction = fn(this, ...args)
            if (endInterfaceFunction) {
                this.EndInterfaceComponents.push(endInterfaceFunction)
            }
        }
        RemoveInterfaceComponents() {
            for (let endInterfaceComponent of this.EndInterfaceComponents) {
                endInterfaceComponent()
            }
            this.EndInterfaceComponents = []
        }
        OnRemove() {
            this.RemoveInterfaceComponents()
        }
        constructor() {
            super()
            this.Frame = new Frame(this.MainFrame)
            this.Frame.BorderSizePixel = 0
            this.Frame.Size = new UDim2(1, 0, 1, 0)
            if (this instanceof Panel) {
                this.Color = GameVisualSettings.PanelColor
            }
            this.MainFrame.AncestryChanged.Connect(() => {
                if (!this.MainFrame.Parent) {
                    this.OnRemove()
                }
            })
        }
    }

    export class Area extends Panel {
        constructor() {
            super()
            let player = Players.LocalPlayer
            if (player) {
                this.Transparency = 1
                this.Parent = player.WaitForChild('PlayerGui').WaitForChild('ScreenGui')
            }
        }
    }

    export class TexturePanel extends Panel {
        ImageLabel: ImageLabel
        set Image(prop: string) {
            this.ImageLabel.Image = prop
        }
        set ImageTransparency(prop: number) {
            this.ImageLabel.ImageTransparency = prop
        }
        set Transparency(prop: number) {
            this.ImageLabel.ImageTransparency = prop
        }
        set Color(prop: Color3) {
            this.ImageLabel.ImageColor3 = prop
            this.CheckColorAndLinkIfNecessary(prop, this.ImageLabel)
        }
        get Color() {
            return this.ImageLabel.BackgroundColor3
        }
        set NineSlice(prop: boolean) {
            if (prop) {
                this.ImageLabel.ScaleType = Enum.ScaleType.Slice
                this.ImageLabel.SliceCenter = new Rect(GameVisualSettings.NineSlice, GameVisualSettings.NineSlice, GameVisualSettings.ImageSize - GameVisualSettings.NineSlice, GameVisualSettings.ImageSize - GameVisualSettings.NineSlice)
            } else {
                this.ImageLabel.ScaleType = Enum.ScaleType.Crop
            }
        }
        constructor() {
            super()
            this.ImageLabel = new ImageLabel(this.MainFrame)
            this.ImageLabel.ZIndex = this.MainFrame.ZIndex + 1 // essential
            this.ImageLabel.Size = new UDim2(1, 0, 1, 0) // essential
            this.ImageLabel.BackgroundTransparency = 1 // essential
            this.Frame.Transparency = 1
            this.NineSlice = true
            if (this instanceof TexturePanel) {
                this.Color = GameVisualSettings.TexturePanelColor
                this.Image = GameVisualSettings.TexturePanelImage
            }
        }
    }

    export class TextureButton extends TexturePanel {
        ImageButton: ImageButton
        set Active(prop: boolean) {
            this.ImageButton.Active = prop
            this.ImageButton.Selectable = prop
            if (prop) {
            } else {
            }
        }
        get MouseClick() {
            return this.ImageButton.MouseButton1Down
        }
        constructor() {
            super()
            this.ImageButton = new ImageButton(this.Frame)
            this.ImageButton.ZIndex = this.ImageLabel.ZIndex + 1 // essential
            this.ImageButton.Size = new UDim2(1, 0, 1, 0) // essential
            this.ImageButton.BackgroundTransparency = 1 // essential
            this.ImageButton.ImageTransparency = 1 // essential
            if (this instanceof TextureButton) {
                this.Image = GameVisualSettings.TextureButtonImage
                this.Color = GameVisualSettings.TextureButtonColor
            }
            this.Active = true
        }
    }

    export class TypePanel extends TextureButton {
        TextLabel: TextLabel
        set Text(prop: any) {
            this.TextLabel.Text = tostring(prop)
        }
        get Text() {
            return this.TextLabel.Text
        }
        set TextColor3(prop: Color3) {
            this.TextLabel.TextColor3 = prop
        }
        set Font(prop: Enum.Font) {
            this.TextLabel.Font = prop
        }
        get TextBounds() {
            return this.TextLabel.TextBounds
        }
        ConstrainSizeToTextBounds() {
            this.Size = new UDim2(0, this.TextBounds.X + 20, this.Size.Y.Scale, this.Size.Y.Offset)
        }
        FollowConstraintSizeToTextBounds() {
            this.ConstrainSizeToTextBounds()
            this.TextLabel.GetPropertyChangedSignal('TextBounds').Connect(this.ConstrainSizeToTextBounds)
        }
        constructor() {
            super()
            this.TextLabel = new TextLabel(this.Frame)
            this.TextLabel.ZIndex = this.ImageButton.ZIndex + 1 // essential
            this.TextLabel.Size = new UDim2(1, 0, 1, 0) // essential
            this.TextLabel.BackgroundTransparency = 1 // essential
            this.TextLabel.TextScaled = GameVisualSettings.LabelFontScaled
            this.TextColor3 = GameVisualSettings.LabelTextColor
            if (this instanceof TypePanel) {
                this.Color = GameVisualSettings.TypePanelColor
                this.Font = GameVisualSettings.TypePanelFont
                CollectionService.AddTag(this.TextLabel, 'TypePanelHost')
            }
            this.Image = GameVisualSettings.TypePanelImage
            if (this instanceof TypePanel) {
                this.ImageButton.Size = new UDim2()
                this.Active = false
            }
        }
    }

    export class TypeButton extends TypePanel {
        constructor() {
            super()
            this.Image = GameVisualSettings.TypeButtonImage
            if (this instanceof TypeButton) {
                this.Font = GameVisualSettings.TypeButtonFont
                CollectionService.AddTag(this.TextLabel, 'TypeButtonHost')
            }
            this.Color = GameVisualSettings.TypeButtonColor
        }
    }

    export class TypeBox extends TexturePanel {
        TextBox: TextBox
        set Text(prop: string) {
            this.TextBox.Text = prop
        }
        get Text() {
            return this.TextBox.Text
        }
        set TextColor3(prop: Color3) {
            this.TextBox.TextColor3 = prop
        }
        set Font(prop: Enum.Font) {
            this.TextBox.Font = prop
        }
        get TextBounds() {
            return this.TextBox.TextBounds
        }
        ConstrainSizeToTextBounds() {
            this.Size = new UDim2(0, this.TextBounds.X + 20, this.Size.Y.Scale, this.Size.Y.Offset)
        }
        FollowConstrainSizeToTextBounds() {
            this.ConstrainSizeToTextBounds()
            this.TextBox.GetPropertyChangedSignal('TextBounds').Connect(this.ConstrainSizeToTextBounds)
        }
        constructor() {
            super()
            this.TextBox = new TextBox(this.Frame)
            this.TextBox.ZIndex = this.ImageLabel.ZIndex + 1 // essential
            this.TextBox.Size = new UDim2(1, 0, 1, 0) // essential
            this.TextBox.BackgroundTransparency = 1 // essential
            this.TextBox.TextScaled = GameVisualSettings.LabelFontScaled
            this.TextBox.Text = '>>'
            if (this instanceof TypeBox) {
                this.Color = GameVisualSettings.TypeBoxColor
                this.Font = GameVisualSettings.TypeBoxFont
                CollectionService.AddTag(this.TextBox, 'TypeBoxHost')
            }
            this.TextColor3 = GameVisualSettings.LabelTextColor
        }
    }

    export class PropertyPanel extends Primitive {
        MyValue: any
        SetValueFunction: ((prop: any) => void) | undefined
        BindableEvent: BindableEvent
        set Value(prop: any) {
            this.MyValue = prop
            if (this.SetValueFunction) {
                this.SetValueFunction(prop)
            }
            this.BindableEvent.Fire()
        }
        get Value() {
            return this.MyValue
        }
        get ValueChanged(): RBXScriptSignal {
            return this.BindableEvent.Event
        }
        constructor(variable: any) {
            super()
            this.BindableEvent = new BindableEvent(this.MainFrame)
            let hostValue: any | undefined
            if (variable instanceof Instance) {
                // Link the two values using remotes
                hostValue = variable
                ;(hostValue.Changed as RBXScriptSignal).Connect(() => {
                    if (hostValue) {
                        this.Value = hostValue.Value
                    }
                })
                variable = variable.Value
            }
            if (hostValue) {
                this.ValueChanged.Connect(() => {
                    if (hostValue) {
                        CallRemote('ChangeValue', undefined, hostValue, this.Value)
                    }
                })
            }
            if (typeof variable === 'string') {
                let typeBox = C('TypeBox', this)
                this.SetValueFunction = prop => {
                    typeBox.Text = prop
                }
                typeBox.TextBox.FocusLost.Connect(enterPressed => {
                    if (enterPressed) {
                        wait()
                        this.Value = typeBox.Text
                    }
                })
                this.Value = variable
            } else if (typeof variable === 'number') {
                let incrementWidth = 20
                let incrementUp = C('TextureButton', this, { Size: new UDim2(0, incrementWidth, 0.5, 0), Color: GameVisualSettings.DynamicColorPalette.Color1 })
                let incrementDown = C('TextureButton', this, { Size: new UDim2(0, incrementWidth, 0.5, 0), Position: new UDim2(0, 0, 0.5, 0), Color: GameVisualSettings.DynamicColorPalette.Color3 })
                let typeBox = C('TypeBox', this, { Size: new UDim2(1, -incrementWidth, 1, 0), Position: new UDim2(0, incrementWidth, 0, 0) })
                this.SetValueFunction = prop => {
                    typeBox.Text = prop
                }
                typeBox.TextBox.FocusLost.Connect(enterPressed => {
                    if (enterPressed) {
                        wait()
                        let num = tonumber(typeBox.Text)
                        if (num) {
                            this.Value = num
                        } else {
                            typeBox.Text = this.Value
                        }
                    }
                })
                this.Value = variable
            } else if (typeof variable === 'boolean') {
                let switchPanel = C('TexturePanel', this, { Size: new UDim2(1, 0, 1, 0), Position: new UDim2(0, 0, 0, 0), Color: Color3.fromRGB(0, 0, 0) })
                let switchButton = C('TextureButton', switchPanel, { Size: new UDim2(0, 20, 0, 20), Position: new UDim2(), Color: Color3.fromRGB(255, 255, 255) })
                switchButton.NineSlice = false
                this.SetValueFunction = bool => {
                    switchButton.Position = new UDim2(bool ? 1 : 0, bool ? -20 : 0, 0, 0)
                }
                switchButton.MouseClick.Connect(() => {
                    let b = this.Value
                    this.Value = !b
                })
                this.Value = variable
            } else if (variable instanceof Color3) {
                let textureButton = C('TextureButton', this)
                let panel: Panel | undefined
                let removePanel = () => {
                    if (panel) {
                        panel.Destroy()
                        panel = undefined
                    }
                }
                this.SetValueFunction = prop => {
                    textureButton.Color = prop
                }
                textureButton.MouseClick.Connect(() => {
                    if (panel && panel.Parent) {
                        removePanel()
                    } else {
                        let player = Players.LocalPlayer as Player
                        propertyMenuArea.Frame.ClearAllChildren()
                        let newVariable = this.Value as Color3
                        let sizeY = 96,
                            sizeX = textureButton.AbsoluteSize.X,
                            posX = textureButton.AbsolutePosition.X,
                            posY = textureButton.AbsolutePosition.Y,
                            hueWidth = 16
                        panel = C('TexturePanel', propertyMenuArea, { Position: new UDim2(0, posX + sizeX + 5, 0, posY), Size: new UDim2(0, sizeY + hueWidth, 0, sizeY) })
                        lockElementToFrame(panel.MainFrame)
                        let forePanel = C('Panel', panel, { TotalPadding: 5, Transparency: 1 })
                        let colorPanel = C('Panel', forePanel, { Size: new UDim2(1, -hueWidth, 1, 0) })
                        let saturationPanel = C('TextureButton', colorPanel, { Image: 'rbxgameasset://saturation_value_gradient', Color: new Color3(1, 1, 1), NineSlice: false })
                        let huePanel = C('TextureButton', forePanel, { Image: 'rbxgameasset://hue_gradient', Size: new UDim2(0, hueWidth, 1, 0), Position: new UDim2(1, -hueWidth, 0, 0), Color: new Color3(1, 1, 1), NineSlice: false })
                        let barHue = C('Panel', huePanel, { Size: new UDim2(1, 0, 0, 5), Color: Color3.fromRGB(0, 0, 0) })
                        let barHighlight = C('Panel', barHue, { Size: new UDim2(1, 0, 0, 3), Position: new UDim2(0, 0, 0, 1), Color: Color3.fromRGB(255, 255, 255) })
                        let barElse = C('Panel', saturationPanel, { Size: new UDim2(0, 5, 0, 5), Color: Color3.fromRGB(0, 0, 0) })
                        barHighlight = C('Panel', barElse, { Size: new UDim2(0, 3, 0, 3), Position: new UDim2(0, 1, 0, 1), Color: Color3.fromRGB(255, 255, 255) })
                        let startHSV = Color3.toHSV(newVariable)
                        let h: number = startHSV[0],
                            s: number = startHSV[1],
                            v: number = 1 - startHSV[2]
                        let setHSV = (nH?: number, nS?: number, nV?: number) => {
                            if (nH) h = nH
                            if (nS) s = nS
                            if (nV) v = nV
                            let color = Color3.fromHSV(h, s, 1 - v)
                            this.Value = color
                            barHue.Position = new UDim2(0, 0, h, -2)
                            barElse.Position = new UDim2(s, -2, v, -2)
                            colorPanel.Color = Color3.fromHSV(h, 1, 1)
                        }
                        setHSV(h, s, v)
                        let module = (object: TextureButton, followHue: boolean) => {
                            object.MouseClick.Connect(() => {
                                let player = Players.LocalPlayer
                                if (player) {
                                    let mouse = player.GetMouse()
                                    let update = () => {
                                        let x = mouse.X,
                                            y = mouse.Y
                                        let absolutePosition = object.AbsolutePosition,
                                            absoluteSize = object.AbsoluteSize
                                        let ratioX = math.min(math.max((x - absolutePosition.X) / absoluteSize.X, 0), 1)
                                        let ratioY = math.min(math.max((y - absolutePosition.Y) / absoluteSize.Y, 0), 1)
                                        if (followHue) {
                                            setHSV(ratioY)
                                        } else {
                                            setHSV(undefined, ratioX, ratioY)
                                        }
                                    }
                                    let moveConnection = mouse.Move.Connect(update)
                                    // ugly hack
                                    let inputConnection2: RBXScriptConnection
                                    let [_, inputConnection] = BindInputs([
                                        Enum.UserInputType.MouseButton1,
                                        undefined,
                                        () => {
                                            moveConnection.Disconnect()
                                            inputConnection2.Disconnect()
                                        },
                                    ])
                                    if (inputConnection) {
                                        inputConnection2 = inputConnection
                                    }
                                    update()
                                }
                            })
                        }
                        module(saturationPanel, false)
                        module(huePanel, true)
                    }
                })
                this.Value = variable
            } else if (variable) {
                let tableVariable = variable as any[]
                let typeButton = C('TypeButton', this)
                let panel: Panel | undefined
                let removePanel = () => {
                    if (panel) {
                        panel.Destroy()
                        panel = undefined
                    }
                }
                this.SetValueFunction = element => {
                    let text
                    if (CustomCheckTypeOf(element, 'EnumItem')) {
                        text = EnumString(element)
                    } else {
                        text = element
                    }
                    typeButton.Text = text
                    removePanel()
                }
                typeButton.MouseClick.Connect(() => {
                    if (panel && panel.Parent) {
                        removePanel()
                    } else {
                        let player = Players.LocalPlayer as Player
                        propertyMenuArea.Frame.ClearAllChildren()
                        let sizeX = typeButton.AbsoluteSize.X,
                            sizeY = 100
                        let posX = typeButton.AbsolutePosition.X,
                            posY = typeButton.AbsolutePosition.Y
                        panel = C('TexturePanel', propertyMenuArea, { Position: new UDim2(0, posX + sizeX + 5, 0, posY), Size: new UDim2(0, 200, 0, sizeY) })
                        lockElementToFrame(panel.MainFrame)
                        let forePanel = C('Panel', panel, { TotalPadding: 5, Transparency: 1 })
                        let container = C('Container', forePanel, { Style: 'Grid', CellSize: new UDim2(1, 0, 0, 30) })
                        for (let index in tableVariable) {
                            let element = tableVariable[index]
                            let button: TextureButton
                            if (typeof element === 'object') {
                                button = C('TextureButton', container, {})
                                let myContainer = C('Container', button, { Style: 'Grid', CellSize: new UDim2(1 / ObjectArrayLength(element), 0, 1, 0) })
                                for (let index in element) {
                                    C('TexturePanel', myContainer, { Color: element[index] })
                                }
                            } else {
                                let text
                                if (CustomCheckTypeOf(element, 'EnumItem')) {
                                    text = EnumString(element)
                                } else {
                                    text = element
                                }
                                button = C('TypeButton', container, { Text: text })
                            }
                            button.MouseClick.Connect(() => {
                                this.Value = element
                            })
                        }
                    }
                })
                this.Value = tableVariable[0]
            }
        }
    }

    export class PropertyLabel extends Primitive {
        TypeLabel: TypePanel
        PropertyPanel: PropertyPanel
        constructor(variable: any, name = 'Undefined') {
            super()
            this.Name = name
            let typeDistance = 0.7
            this.TypeLabel = C('TypePanel', this, { Text: name, Size: new UDim2(typeDistance, 0, 1, 0) })
            this.PropertyPanel = C('PropertyPanel', this, {}, variable)
            this.PropertyPanel.Size = new UDim2(1 - typeDistance, 0, 1, 0)
            this.PropertyPanel.Position = new UDim2(typeDistance, 0, 0, 0)
        }
    }

    export class Container {
        Folder: Folder
        Layout: UIGridLayout | UIListLayout
        ScrollingFrame: ScrollingFrame
        set Parent(parent: Instance | undefined) {
            this.ScrollingFrame.Parent = parent
        }
        get Parent() {
            return this.ScrollingFrame.Parent
        }
        UpdateNewLayout() {
            this.Layout.GetPropertyChangedSignal('AbsoluteContentSize').Connect(() => {
                if (this.ScrollingFrame.ScrollingDirection === Enum.ScrollingDirection.X) {
                    let size = this.Layout.AbsoluteContentSize.X
                    this.ScrollingFrame.CanvasSize = new UDim2(0, size, 0, 0)
                } else {
                    let size = this.Layout.AbsoluteContentSize.Y
                    this.ScrollingFrame.CanvasSize = new UDim2(0, 0, 0, size)
                }
            })
        }
        SetGridLayout() {
            this.Layout = new UIGridLayout(this.Folder)
            this.Padding = 0
            this.CellSize = new UDim2(0, 50, 0, 50)
            this.UpdateNewLayout()
        }
        SetListLayout() {
            this.Layout = new UIListLayout(this.Folder)
            this.Padding = 0
            this.UpdateNewLayout()
        }
        set VAlignment(prop: 'Top' | 'Center' | 'Bottom') {
            this.Layout.VerticalAlignment = prop === 'Top' ? Enum.VerticalAlignment.Top : prop === 'Center' ? Enum.VerticalAlignment.Center : Enum.VerticalAlignment.Bottom
        }
        set HAlignment(prop: 'Left' | 'Center' | 'Right') {
            this.Layout.HorizontalAlignment = prop === 'Left' ? Enum.HorizontalAlignment.Left : prop === 'Center' ? Enum.HorizontalAlignment.Center : Enum.HorizontalAlignment.Right
        }
        set SortOrder(prop: Enum.SortOrder) {
            this.Layout.SortOrder = prop
        }
        set FillDirection(prop: Enum.FillDirection) {
            this.Layout.FillDirection = prop
            if (prop === Enum.FillDirection.Horizontal) {
                // this.ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
                // this.ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
                this.ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
            } else {
                // this.ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
                // this.ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
                this.ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
            }
        }
        set CellSize(prop: UDim2) {
            if (this.Layout instanceof UIGridLayout) {
                this.Layout.CellSize = prop
            } else {
                warn('Tried setting cellsize of a simple layout')
            }
        }
        set Padding(prop: number) {
            if (this.Layout instanceof UIGridLayout) {
                this.Layout.CellPadding = new UDim2(0, prop, 0, prop)
            } else {
                this.Layout.Padding = new UDim(this.Layout.FillDirection === Enum.FillDirection.Horizontal ? prop : 0, this.Layout.FillDirection === Enum.FillDirection.Vertical ? prop : 0)
            }
        }
        set Style(prop: 'Grid' | 'List') {
            if (this.Layout) {
                this.Layout.Destroy()
            }
            if (prop === 'Grid') {
                this.SetGridLayout()
            } else {
                this.SetListLayout()
            }
            this.VAlignment = 'Center'
            this.HAlignment = 'Center'
        }
        constructor(parent?: Instance) {
            this.ScrollingFrame = new ScrollingFrame(parent)
            this.ScrollingFrame.Size = new UDim2(1, 0, 1, 0)
            this.ScrollingFrame.BackgroundTransparency = 1
            this.ScrollingFrame.CanvasSize = new UDim2()
            this.ScrollingFrame.ScrollBarThickness = 5
            this.ScrollingFrame.ZIndex = 1000
            this.ScrollingFrame.ScrollBarImageColor3 = GameVisualSettings.ScrollBarColor
            this.ScrollingFrame.ScrollBarImageTransparency = 0
            this.Folder = new Folder(this.ScrollingFrame)
            this.Style = 'Grid'
        }
    }
}

export function C<T extends keyof typeof UserInterfaceTypes, C extends InstanceType<typeof UserInterfaceTypes[T]>, K extends keyof C>(className: T, parent?: GuiObject | UserInterfaceTypes.Primitive | UserInterfaceTypes.Container, properties?: { [index in K]: C[K] }, ...args: any[]): C {
    let newClass = new (UserInterfaceTypes as any)[className](...args) as any
    if (parent) {
        let nParent = undefined
        if (CustomCheckTypeOf(nParent, 'Userdata')) {
            nParent = parent
        } else {
            if ((parent as any)['Frame']) {
                nParent = (parent as any)['Frame']
            } else if ((parent as any)['Folder']) {
                nParent = (parent as any)['Folder']
            }
        }
        if (nParent) {
            newClass.Parent = nParent
        } else {
            warn('No nParent')
        }
    }
    if (properties) {
        if ((properties as any)['Style']) {
            newClass['Style'] = (properties as any)['Style'] as any
        }
        for (let key in properties) {
            if (key !== 'Style') {
                newClass[key] = properties[key] as any
            }
        }
    }
    return newClass
}

let lockElementToFrame = (element: Frame) => {
    let parent = element.Parent as Frame
    let parentAbsolutePosition = parent.AbsolutePosition,
        parentAbsoluteSize = parent.AbsoluteSize
    let myAbsolutePosition = element.AbsolutePosition,
        myAbsoluteSize = element.AbsoluteSize
    let yDifference = myAbsolutePosition.Y + myAbsoluteSize.Y - (parentAbsolutePosition.Y + parentAbsoluteSize.Y)
    if (yDifference > -15) {
        let position = element.Position
        element.Position = new UDim2(position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset - yDifference - 15)
    }
}

AvailableInterfaceComponents = {
    TextCenterUnderline: object => {
        if (object instanceof UserInterfaceTypes.TypePanel || object instanceof UserInterfaceTypes.TypeButton) {
            let underline = new Frame(object.Frame)
            underline.BorderSizePixel = 0
            underline.ZIndex = object.TextLabel.ZIndex - 1
            underline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            underline.BackgroundTransparency = 0.8
            let updateFrame = () => {
                let textBoundsX = math.min(object.Frame.AbsoluteSize.X - 10, object.TextBounds.X + 10)
                let height = object.TextBounds.Y
                underline.Size = new UDim2(0, textBoundsX, 0, height)
                underline.Position = new UDim2(0.5, -textBoundsX / 2, 0.5, -height / 2)
            }
            let connection = object.TextLabel.GetPropertyChangedSignal('TextBounds').Connect(updateFrame)
            // NOTE: may want to remove this second connection for something better
            let connection2 = object.TextLabel.GetPropertyChangedSignal('AbsolutePosition').Connect(updateFrame)
            let connection3 = object.TextLabel.GetPropertyChangedSignal('AbsolutePosition').Connect(updateFrame)
            updateFrame()
            return () => {
                underline.Destroy()
                connection.Disconnect()
                connection2.Disconnect()
                connection3.Disconnect()
            }
        }
    },
    ButtonReaction_Default: object => {
        if (object instanceof UserInterfaceTypes.TextureButton) {
            let remainColor: Color3 | undefined
            object.ImageButton.MouseEnter.Connect(() => {
                let currentColor = object.Color
                let factor = 0.8
                object.Color = new Color3(currentColor.r * factor, currentColor.g * factor, currentColor.b * factor)
                remainColor = object.Color
            })
            let endFunction = () => {
                if (remainColor && remainColor === object.Color) {
                    object.ImageLabel.ImageColor3 = object.Color
                }
                remainColor = undefined
            }
            object.ImageButton.MouseLeave.Connect(endFunction)
            return endFunction
        }
    },
    ButtonReaction_Slider: object => {
        if (object instanceof UserInterfaceTypes.TextureButton) {
            let slider = new Frame(object.Frame)
            slider.ZIndex = object.ImageButton.ZIndex + 1
            slider.BorderSizePixel = 0
            let defaultColor = Color3.fromRGB(20, 20, 20)
            let flashColor = Color3.fromRGB(255, 255, 255)
            slider.BackgroundColor3 = defaultColor
            slider.Size = new UDim2(0, 10, 1, 0)
            object.ImageButton.MouseEnter.Connect(() => {
                TweenService.Create(slider, new TweenInfo(0.2), { Size: new UDim2(0, 50, 1, 0), BackgroundColor3: flashColor }).Play()
                wait(0.2)
                TweenService.Create(slider, new TweenInfo(0.4), { BackgroundColor3: defaultColor }).Play()
            })
            let endFunction = () => {
                TweenService.Create(slider, new TweenInfo(0.1), { Size: new UDim2(0, 10, 1, 0), BackgroundColor3: defaultColor }).Play()
            }
            object.ImageButton.MouseLeave.Connect(endFunction)
            return endFunction
        }
    },
    ButtonReaction_TextTip: (object, tip: string) => {
        if (object instanceof UserInterfaceTypes.TextureButton) {
            let leftOver: UserInterfaceTypes.TypePanel | undefined
            object.ImageButton.MouseEnter.Connect(() => {
                leftOver = C('TypePanel', texttipContainer, { Text: tip, Size: new UDim2(1, 0, 0, 20), Color: GameVisualSettings.TextTipBackgroundColor, TextColor3: GameVisualSettings.TextTipTextColor })
                leftOver.ConstrainSizeToTextBounds()
            })
            let endFunction = () => {
                if (leftOver) {
                    leftOver.Destroy()
                    leftOver = undefined
                }
            }
            object.ImageButton.MouseLeave.Connect(endFunction)
            return endFunction
        }
    },
}

propertyMenuArea = C('Area', undefined, { Name: 'PropertyMenuArea', ZIndex: 100 })
let area = C('Area', undefined, { Name: 'ClientUserInterface', ZIndex: 100 })
let mousePrimitive = C('Primitive', area, {})
let TextTipPrimitive = C('Primitive', mousePrimitive, { Position: new UDim2(0, 5, 0, 25) })
texttipContainer = C('Container', TextTipPrimitive, { Style: 'List', VAlignment: 'Top', HAlignment: 'Left' })
let player = game.Players.LocalPlayer as Player
let mouse = player.GetMouse()
mouse.Move.Connect(() => {
    mousePrimitive.Position = new UDim2(0, mouse.X, 0, mouse.Y)
})
