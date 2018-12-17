import { CreateNewEffect } from '../msc/helper-functions'
import { SetPartCollisionGroup } from '../demo/collision-groups'
//import { GetEnemyFromPart } from '../demo/character-manager'
import { Workspace, Debris } from 'rbx-services'

class Bullet {
    BulletBonuses: (keyof typeof Classes_BulletBonus)[] = []
    Fire(frame: CFrame) {
        let instanceBullet = CreateNewEffect('FriendlyBullet', Workspace) as BasePart
        SetPartCollisionGroup(instanceBullet, 'FriendlyBullets')
        instanceBullet.CFrame = frame
        instanceBullet.Velocity = new Vector3(0, 0, -100)
        instanceBullet.Touched.Connect(part => {
            // let enemy = GetEnemyFromPart(part)
            // if (enemy) {
            //     enemy.TakeDamage(40)
            //     instanceBullet.Destroy()
            // }
        })
        Debris.AddItem(instanceBullet, 2)
    }
}
export type T_Bullet = Bullet
export type T_BulletName = keyof typeof Classes_Bullet

class BulletBonus {
    constructor(bullet: Bullet) {}
}

namespace Classes_BulletBonus {
    export class Homing extends BulletBonus {}
    export class Homing3 extends BulletBonus {}
}
export namespace Classes_Bullet {
    export class SimpleBullet extends Bullet {
        constructor() {
            super()
            this.BulletBonuses = ['Homing']
        }
    }
}
