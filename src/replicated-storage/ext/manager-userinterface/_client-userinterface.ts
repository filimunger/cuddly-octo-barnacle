import { Players, StarterGui } from 'rbx-services'
// Note: ugly hack
if (!(Players.LocalPlayer as Player).WaitForChild('PlayerGui').FindFirstChild('ScreenGui')) {
    StarterGui.ScreenGui.Clone().Parent = (Players.LocalPlayer as Player).WaitForChild('PlayerGui')
}

import { BringElementToFront, ConvertObjectToArray, EnumString } from '../msc/helper-functions'
import { AddInternalMenuButton } from './_client-hub-menu'
import { C, GameVisualSettings } from './userinterface-module'
import { AvailablePalettes, VisualSettings } from './visual-settings-module'
export = true

let menu = AddInternalMenuButton('Modify User Interface')
let container = C('Container', menu, { Style: 'Grid', CellSize: new UDim2(1, 0, 0, 40) })
let fontFamily: Enum.Font[] = [Enum.Font.Antique, Enum.Font.Arcade, Enum.Font.Arial, Enum.Font.ArialBold, Enum.Font.Bodoni, Enum.Font.Cartoon, Enum.Font.Code, Enum.Font.Fantasy, Enum.Font.Garamond, Enum.Font.Highway, Enum.Font.Legacy, Enum.Font.SciFi, Enum.Font.SourceSans, Enum.Font.SourceSansBold, Enum.Font.SourceSansItalic, Enum.Font.SourceSansLight, Enum.Font.SourceSansSemibold]
let remarks: { [index in keyof typeof VisualSettings.prototype]?: any } = {
    ColorPalette: BringElementToFront(ConvertObjectToArray(AvailablePalettes), GameVisualSettings.ColorPalette),
    TypePanelFont: BringElementToFront(fontFamily, EnumString(GameVisualSettings.TypePanelFont)),
    TypeButtonFont: BringElementToFront(fontFamily, EnumString(GameVisualSettings.TypeButtonFont)),
    TypeBoxFont: BringElementToFront(fontFamily, EnumString(GameVisualSettings.TypeBoxFont)),
}
for (let index in remarks) {
    let element = (remarks as any)[index]
    let propertyLabel = C('PropertyLabel', container, {}, element, index)
    propertyLabel.PropertyPanel.ValueChanged.Connect(() => {
        ;(GameVisualSettings as any)[index] = propertyLabel.PropertyPanel.Value
    })
}
