import { SimpleVector, CreateNewEffect } from '../msc/helper-functions'
import { Workspace } from 'rbx-services'
import { SetPartCollisionGroup } from '../demo/collision-groups'
//import { GetFriendlyFromPart } from '../demo/character-manager'

let bulletSave = CreateNewEffect('EnemyBullet') as Part

class Card {
    BulletsPerArray = 2
    IndividualArraySpread = 90
    TotalBulletArrays = 1
    CurrentSpinSpeed = 15
    SpinSpeedChangeRate = 0
    SpinReversal = 0
    MaxSpinSpeed = 30
    FireRate = 4
    BulletSpeed = 4
    BulletAcceleration = 0
    BulletCurve = 0
    ObjectWidth = 16
    ObjectHeight = 16
    XOffset = 0
    YOffset = 0
    Play = () => {
        let targetFrame = new CFrame(SimpleVector(new Vector3()), SimpleVector(new Vector3(1, 1, 1)))
        let startFrame = targetFrame.mul(CFrame.Angles(0, -math.rad((this.TotalBulletArrays * this.IndividualArraySpread) / 2), 0))
        let degreesPerBulletInArray = this.IndividualArraySpread / this.BulletsPerArray
        for (let arrayIndex = 0; arrayIndex < this.TotalBulletArrays; arrayIndex++) {
            for (let bulletIndex = 0; bulletIndex < this.BulletsPerArray; bulletIndex++) {
                let bulletFrame = startFrame.mul(CFrame.Angles(0, math.rad(arrayIndex * this.IndividualArraySpread + degreesPerBulletInArray), 0))
                let myBullet = bulletSave.Clone() as Part
                myBullet.Parent = Workspace
                SetPartCollisionGroup(myBullet, 'EnemyBullets')
                myBullet.CFrame = bulletFrame
                myBullet.Velocity = myBullet.CFrame.LookVector.mul(50)
                myBullet.Touched.Connect(part => {
                    // let character = GetFriendlyFromPart(part)
                    // if (character) {
                    //     character.Die()
                    // }
                })
            }
        }
    }
}
export type T_Card = Card
export type T_CardName = keyof typeof Classes_Card

export namespace Classes_Card {
    export class RandomizedBossCard extends Card {
        constructor() {
            super()

            let cardStrength = 100
        }
    }
    export class NoidCard extends Card {
        constructor() {
            super()
            this.BulletsPerArray = 2
            this.IndividualArraySpread = 40
            this.TotalBulletArrays = 1
            this.CurrentSpinSpeed = 15
            this.SpinSpeedChangeRate = 0
            this.SpinReversal = 0
            this.MaxSpinSpeed = 30
            this.FireRate = 4
            this.BulletSpeed = 4
            this.BulletAcceleration = 0
            this.BulletCurve = 0
            this.ObjectWidth = 16
            this.ObjectHeight = 16
            this.XOffset = 0
            this.YOffset = 0
        }
    }
}
