import { SimpleVector, CreateNewEffect } from '../../msc/helper-functions'
import { Workspace, TweenService } from 'rbx-services'
import { SetPartCollisionGroup } from '../main/collision-groups'
import { GetFriendlyFromPart } from '../main/character-manager'

let bulletSave = CreateNewEffect('EnemyBullet') as Part

let applyAngleToFrame = (frame: CFrame, angle: number) => {
    return frame.mul(CFrame.Angles(0, math.rad(angle), 0))
}

class Card {
    StartFrame: CFrame
    DegreesPerBulletInArray: number
    // Array
    TotalBulletArrays = 1
    IndividualArraySpread = 360
    BulletsPerArray = 12
    FireRate = 0.2
    XOffset = 0
    YOffset = 0
    // Array Spin
    CurrentSpinSpeed = 15
    SpinSpeedChangeAmount = 0.5
    SpinSpeedChangeSpeed = 0.2
    MaxSpinSpeed = 30
    // Bullet Properties
    BulletInitialVelocity = 4
    BulletAcceleration = 1
    BulletCurve = 15
    ObjectSize = 4

    Fire() {
        for (let arrayIndex = 0; arrayIndex < this.TotalBulletArrays; arrayIndex++) {
            for (let bulletIndex = 0; bulletIndex < this.BulletsPerArray; bulletIndex++) {
                print('addbullet')
                let bulletFrame = applyAngleToFrame(this.StartFrame, arrayIndex * this.IndividualArraySpread + this.DegreesPerBulletInArray)
                let myBullet = bulletSave.Clone() as Part
                myBullet.Size = new Vector3(this.ObjectSize, this.ObjectSize, this.ObjectSize)
                myBullet.Parent = Workspace
                SetPartCollisionGroup(myBullet, 'EnemyBullets')
                myBullet.CFrame = bulletFrame
                let bulletCurrentVelocity = this.BulletInitialVelocity
                myBullet.Velocity = myBullet.CFrame.LookVector.mul(bulletCurrentVelocity)
                myBullet.Touched.Connect(part => {
                    let character = GetFriendlyFromPart(part)
                    if (character) {
                        character.Die()
                    }
                })
                if (this.BulletAcceleration !== 0) {
                    coroutine.wrap(() => {
                        while (true) {
                            myBullet.CFrame = applyAngleToFrame(myBullet.CFrame, this.BulletCurve)
                            bulletCurrentVelocity += this.BulletAcceleration
                            TweenService.Create(myBullet, new TweenInfo(1), { Velocity: myBullet.CFrame.LookVector.mul(bulletCurrentVelocity) })
                            wait(1)
                        }
                    })()
                }
            }
        }
    }
    Play = (selfFrame: CFrame) => {
        let targetFrame = new CFrame(selfFrame.p, SimpleVector(new Vector3(1, 1, 1)))
        this.StartFrame = applyAngleToFrame(targetFrame, (-this.TotalBulletArrays * this.IndividualArraySpread) / 2)
        this.DegreesPerBulletInArray = this.IndividualArraySpread / this.BulletsPerArray
        coroutine.wrap(() => {
            while (true) {
                this.Fire()
                wait(this.FireRate)
            }
        })()
        if (this.SpinSpeedChangeAmount !== 0) {
            coroutine.wrap(() => {
                while (true) {
                    this.CurrentSpinSpeed += this.SpinSpeedChangeAmount
                    if (math.abs(this.CurrentSpinSpeed) >= this.MaxSpinSpeed) {
                        this.SpinSpeedChangeAmount *= -1
                    }
                    wait(this.SpinSpeedChangeSpeed)
                }
            })
        }
        coroutine.wrap(() => {
            while (true) {
                wait()
                this.StartFrame = applyAngleToFrame(this.StartFrame, this.CurrentSpinSpeed / 20)
            }
        })()
    }
}
export type T_Card = Card
export type T_CardName = keyof typeof Classes_Card

export namespace Classes_Card {
    export class RandomizedBossCard extends Card {
        constructor() {
            super()
            let cardStrength = 1
        }
    }
    export class BaseCard extends Card {}
    export class NoidCard extends Card {
        constructor() {
            super()
        }
    }
}
