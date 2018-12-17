import { Workspace } from 'rbx-services'

import { OriginFrame } from '../demo/module'
import { AddPrimaryPart, CreateNewEffect, WeldModel } from '../msc/helper-functions'

export class Character {
    Name = 'Plane'
    Health = 100
    Model: Model
    BodyGyro: BodyGyro
    BodyVelocity: BodyVelocity
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
        this.BodyVelocity = new BodyVelocity(primaryPart)
        let bodyVelocityForce = 9e9
        this.BodyVelocity.MaxForce = new Vector3(bodyVelocityForce, bodyVelocityForce, bodyVelocityForce)
        this.BodyVelocity.P = bodyVelocityForce
    }
}
export type T_Character = Character
