import { CollectionService } from 'rbx-services'

export type T_Palette = { Color1: Color3; Color2: Color3; Color3: Color3; Color4: Color3; Color5: Color3 }
export let AvailablePalettes = {
    SeaBottomBlue: { Color1: Color3.fromRGB(225, 225, 225), Color2: Color3.fromRGB(140, 146, 162), Color3: Color3.fromRGB(89, 103, 132), Color4: Color3.fromRGB(66, 83, 129), Color5: Color3.fromRGB(47, 47, 49) },
    SisterSunflower: { Color1: Color3.fromRGB(195, 251, 244), Color2: Color3.fromRGB(251, 195, 202), Color3: Color3.fromRGB(251, 244, 195), Color4: Color3.fromRGB(137, 196, 250), Color5: Color3.fromRGB(195, 202, 251) },
    DiscordColors: { Color1: Color3.fromRGB(255, 255, 255), Color2: Color3.fromRGB(114, 137, 218), Color3: Color3.fromRGB(153, 170, 181), Color4: Color3.fromRGB(44, 47, 51), Color5: Color3.fromRGB(35, 39, 42) },
    MetroUIColors: { Color1: Color3.fromRGB(209, 17, 65), Color2: Color3.fromRGB(0, 177, 89), Color3: Color3.fromRGB(0, 174, 219), Color4: Color3.fromRGB(243, 119, 53), Color5: Color3.fromRGB(255, 196, 37) },
    MurkWoods: { Color1: Color3.fromRGB(197, 151, 157), Color2: Color3.fromRGB(75, 143, 140), Color3: Color3.fromRGB(72, 77, 109), Color4: Color3.fromRGB(44, 54, 94), Color5: Color3.fromRGB(43, 25, 61) },
    Poison: { Color1: Color3.fromRGB(223, 243, 228), Color2: Color3.fromRGB(113, 128, 185), Color3: Color3.fromRGB(52, 35, 166), Color4: Color3.fromRGB(46, 23, 96), Color5: Color3.fromRGB(23, 23, 56) },
}

export let PaletteInterfaceRemarks = { Panel: 'PanelColor', TexturePanel: 'TexturePanelColor', TextureButtonDefaultColor: 'TextureButtonColor', TypePanel: 'TypePanelColor', TypeButton: 'TypeButtonColor', TypeBox: 'TypeBoxColor' }
export class VisualSettings {
    PanelColor: Color3
    TexturePanelColor: Color3
    TextureButtonColor: Color3
    TypePanelColor: Color3
    TypeButtonColor: Color3
    TypeBoxColor: Color3
    LabelTextColor = Color3.fromRGB(0, 0, 0)
    IconImage = 'rbxgameasset://hue_gradient'
    TexturePanelImage = 'rbxgameasset://Images/bevel-square-extra-tight'
    TextureButtonImage = 'rbxgameasset://Images/bevel-square-extra-tight'
    TypePanelImage = 'rbxgameasset://Images/bevel-square-extra-tight'
    TypeButtonImage = 'rbxgameasset://Images/bevel-square-extra-tight'
    ImageSize = 256
    NineSlice = 16
    TextTipBackgroundColor = Color3.fromRGB(0, 0, 0)
    TextTipTextColor = Color3.fromRGB(255, 255, 255)
    LabelFontScaled = true
    ScrollBarColor = Color3.fromRGB(255, 255, 255)
    private MyColorPalette: T_Palette
    private MyDynamicColorPalette: T_Palette
    private MyTypePanelFont: Enum.Font
    private MyTypeButtonFont: Enum.Font
    private MyTypeBoxFont: Enum.Font
    set ColorPalette(prop: T_Palette) {
        this.MyColorPalette = prop
        this.PanelColor = this.ColorPalette.Color5
        this.TexturePanelColor = this.ColorPalette.Color4
        this.TextureButtonColor = this.ColorPalette.Color2
        this.TypePanelColor = this.ColorPalette.Color1
        this.TypeButtonColor = this.ColorPalette.Color3
        this.TypeBoxColor = this.ColorPalette.Color1
        for (let index in PaletteInterfaceRemarks) {
            let myColor = (this as any)[(PaletteInterfaceRemarks as any)[index]]
            for (let element of CollectionService.GetTagged(index)) {
                if (element.IsA('GuiObject')) {
                    if (element.IsA('ImageLabel') || element.IsA('ImageButton')) {
                        element.ImageColor3 = myColor
                    } else {
                        element.BackgroundColor3 = myColor
                    }
                }
            }
        }
    }
    get ColorPalette() {
        return this.MyColorPalette
    }
    set DynamicColorPalette(prop: T_Palette) {
        this.MyDynamicColorPalette = prop
    }
    get DynamicColorPalette() {
        return this.MyDynamicColorPalette
    }
    set TypePanelFont(prop: Enum.Font) {
        this.MyTypePanelFont = prop
        for (let instance of CollectionService.GetTagged('TypePanelHost')) {
            ;(instance as TextLabel).Font = prop
        }
    }
    get TypePanelFont() {
        return this.MyTypePanelFont
    }
    set TypeButtonFont(prop: Enum.Font) {
        this.MyTypeButtonFont = prop
        for (let instance of CollectionService.GetTagged('TypeButtonHost')) {
            ;(instance as TextLabel).Font = prop
        }
    }
    get TypeButtonFont() {
        return this.MyTypeButtonFont
    }
    set TypeBoxFont(prop: Enum.Font) {
        this.MyTypeBoxFont = prop
        for (let instance of CollectionService.GetTagged('TypeBoxHost')) {
            ;(instance as TextLabel).Font = prop
        }
    }
    get TypeBoxFont() {
        return this.MyTypeBoxFont
    }
    constructor() {
        this.ColorPalette = AvailablePalettes.MurkWoods
        this.DynamicColorPalette = AvailablePalettes.MetroUIColors
        this.TypePanelFont = Enum.Font.SourceSansBold
        this.TypeButtonFont = Enum.Font.SourceSansBold
        this.TypeBoxFont = Enum.Font.SourceSansBold
    }
}
