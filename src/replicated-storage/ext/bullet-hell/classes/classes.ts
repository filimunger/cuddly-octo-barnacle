import { Workspace } from 'rbx-services'

import { OriginFrame } from '../main/module'
import { AddPrimaryPart, CreateNewEffect, WeldModel } from '../../msc/helper-functions'

export class Character {
    Name = 'Plane'
    Health = 100
    Model: Model
    BodyGyro: BodyGyro
    SetVelocity(newVelocity: Vector3) {
        this.Model.PrimaryPart.Velocity = newVelocity
    }
    constructor(name: string) {
        this.Name = name
        this.Model = CreateNewEffect(this.Name) as Model
        let primaryPart = AddPrimaryPart(this.Model)
        this.Model.SetPrimaryPartCFrame(OriginFrame)
        this.BodyGyro = new BodyGyro(primaryPart)
        let bodyGyroForce = 5000
        this.BodyGyro.MaxTorque = new Vector3(bodyGyroForce, bodyGyroForce, bodyGyroForce)
        this.BodyGyro.P = bodyGyroForce
        this.BodyGyro.CFrame = primaryPart.CFrame
    }
}
export type T_Character = Character
