import { Character, T_Character } from './classes'
import { T_Blaster, Classes_Blaster, T_BlasterName } from './classes-blaster'
import { SetPartCollisionGroup } from '../demo/collision-groups'
import { OriginFrame } from '../demo/module'
import { WeldModel, CreateNewEffect, VariableValue } from '../msc/helper-functions'
import { Workspace } from 'rbx-services'

let CreateBlaster = (blasterName: T_BlasterName, character: T_Character) => {
    let cls = new Classes_Blaster[blasterName](character)
    return cls
}

class Character_Friendly extends Character {
    InternalData: { [index: string]: BoolValue } = {}
    Effects: { [index: string]: ParticleEmitter[] }
    Blasters: T_Blaster[] = []
    Player: Player
    Firing = false
    ClientClicking = false
    ReloadSpeed = 0.1
    HitboxRadius = 3.5
    UnitX = 0
    UnitY = 0
    CurrentUnitVelocity = 0
    UnitVelocity = 230
    SteadyUnitVelocity = 40
    Steady = false
    Lives = 5
    Fire(bool: boolean) {
        this.ClientClicking = bool
        if (bool) {
            if (!this.Firing) {
                this.Firing = true
                this.UpdateInternal('Firing')
                while (this.ClientClicking) {
                    for (let blaster of this.Blasters) {
                        blaster.Fire()
                    }
                    wait(this.ReloadSpeed)
                }
                this.Firing = false
                this.UpdateInternal('Firing')
            }
        }
    }
    Bomb() {}
    Steer(x: number, y: number, steady?: boolean) {
        if (steady !== undefined) {
            this.Steady = steady
            this.Model.PrimaryPart.Transparency = this.Steady ? 0 : 1
            if (this.Steady) {
                this.CurrentUnitVelocity = this.SteadyUnitVelocity
            } else {
                this.CurrentUnitVelocity = this.UnitVelocity
            }
        }
        this.UnitX += x
        this.UnitY += y
        this.BodyGyro.CFrame = OriginFrame.mul(CFrame.Angles(0, 0, -math.rad(45 * this.UnitX * (this.Steady ? 0.5 : 1))))
        this.BodyVelocity.Velocity = new Vector3(this.CurrentUnitVelocity * this.UnitX, 0, this.CurrentUnitVelocity * this.UnitY * -1)

        let blazeBool = this.UnitY !== -1
        for (let effect of this.Effects.Blazer) {
            effect.Enabled = blazeBool
        }
        let cruiseBool = this.UnitY > 0
        for (let effect of this.Effects.Cruiser) {
            effect.Enabled = cruiseBool
        }
    }
    UpdateInternal(id: string) {
        this.InternalData[id].Value = (this as any)[id]
    }
    Die() {
        this.Lives--
        this.UpdateInternal('Lives')
        print('ded')
    }
    constructor(name: string, player: Player) {
        super(name)
        let folder = new Folder(Workspace.WaitForChild('FriendlyData'))
        for (let id of ['Lives', 'Firing']) {
            let variable = (this as any)[id]
            this.InternalData[id] = VariableValue(variable, folder, id)
        }
        this.Model.Parent = Workspace.WaitForChild('FriendlyCharacters')
        this.Player = player
        this.Effects = {
            Blazer: [],
            Cruiser: [],
        }
        for (let instance of this.Model.GetDescendants()) {
            if (instance.IsA('BasePart')) {
                SetPartCollisionGroup(instance, 'FriendlyCharacters')
                // Note: anchored off only for network ownership
                instance.Anchored = false
                instance.SetNetworkOwner(this.Player)
                if (instance !== this.Model.PrimaryPart) {
                    instance.CanCollide = false
                } else {
                    let frame = instance.CFrame
                    instance.Size = new Vector3(this.HitboxRadius * 2, this.HitboxRadius * 2, this.HitboxRadius * 2)
                    ;(instance as Part).Shape = Enum.PartType.Ball
                    instance.CFrame = frame
                    instance.Material = Enum.Material.SmoothPlastic
                    instance.Color = Color3.fromRGB(255, 255, 255)
                }
            } else if (instance.IsA('Attachment')) {
                if (instance.Name === 'Attachment_Blazer') {
                    this.Effects.Blazer.push(CreateNewEffect('Blazer', instance) as ParticleEmitter)
                } else if (instance.Name === 'Attachment_Cruiser') {
                    this.Effects.Cruiser.push(CreateNewEffect('Cruiser', instance) as ParticleEmitter)
                } else if (instance.Name === 'Attachment_Turret') {
                }
            }
        }
        WeldModel(this.Model)
        this.Steer(0, 0, false)
    }
}
export type T_FriendlyCharacter = Character_Friendly
export type T_FriendlyName = keyof typeof Classes_Friendly

export namespace Classes_Friendly {
    export class Plane extends Character_Friendly {
        Name = 'Plane'
        Blasters = [CreateBlaster('SimpleBlaster', this)]
        HitBoxRadius = 5
    }
    export class Bomber extends Character_Friendly {
        Name = 'Bomber'
        HitBoxRadius = 7
        UnitVelocity = 100
    }
}
