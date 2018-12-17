import { CreateNewEffect, RandomFromDictionary, RandomIndexFromDictionary } from '../../msc/helper-functions'
import { SetPartCollisionGroup } from '../demo/collision-groups'
import { Workspace, Debris } from 'rbx-services'
import { GetEnemyFromPart } from '../demo/character-manager'

class Bullet {
    BulletHostName: keyof typeof bulletHosts = 'BasicHost'
    BulletBonuses: (BulletBonus)[] = []
    BulletHost: BasePart
    Fire(frame: CFrame) {
        this.BulletHost = CreateNewEffect(this.BulletHostName, Workspace) as BasePart
        SetPartCollisionGroup(this.BulletHost, 'FriendlyBullets')
        this.BulletHost.CFrame = frame
        Debris.AddItem(this.BulletHost, 2)
    }
}
export type T_Bullet = Bullet
export type T_BulletName = keyof typeof Classes_Bullet

let bulletHosts = {
    BasicHost: true,
}

class BulletBonus {
    Strength = 10
    Bullet: Bullet
    Execute() {}
    constructor(bullet: Bullet) {
        this.Bullet = bullet
    }
}

namespace Classes_BulletGuidance {
    export class Simple extends BulletBonus {
        Execute() {
            this.Bullet.BulletHost.Velocity = new Vector3(0, 0, -100)
        }
    }
    export class Homing extends BulletBonus {
        Execute() {}
    }
    export class Homing3 extends BulletBonus {
        Execute() {}
    }
}

namespace Classes_BulletDamage {
    export class Simple extends BulletBonus {
        Damage = 40
        Execute() {
            this.Bullet.BulletHost.Touched.Connect(part => {
                let enemy = GetEnemyFromPart(part)
                if (enemy) {
                    enemy.TakeDamage(this.Damage)
                    this.Bullet.BulletHost.Destroy()
                }
            })
        }
    }
    export class AreaOfEffect extends BulletBonus {
        Damage = 40
        Execute() {
            this.Bullet.BulletHost.Touched.Connect(part => {
                let enemy = GetEnemyFromPart(part)
                if (enemy) {
                    enemy.TakeDamage(this.Damage)
                    this.Bullet.BulletHost.Destroy()
                }
            })
        }
    }
}
namespace Classes_BulletExtra {
    export class Something extends BulletBonus {
        Execute() {}
    }
}

export namespace Classes_Bullet {
    export class Bomb extends Bullet {
        constructor() {
            super()
            this.BulletBonuses.push(new Classes_BulletGuidance.Homing(this))
            this.BulletBonuses.push(new Classes_BulletDamage.AreaOfEffect(this))
        }
    }
    export class SimpleBullet extends Bullet {
        constructor() {
            super()
            this.BulletBonuses.push(new Classes_BulletGuidance.Simple(this))
            this.BulletBonuses.push(new Classes_BulletDamage.Simple(this))
        }
    }
    export class RandomBullet extends Bullet {
        constructor() {
            super()
            // Random host
            this.BulletHostName = RandomIndexFromDictionary(bulletHosts)
            // Random guidance bonus
            let c0 = RandomFromDictionary(Classes_BulletGuidance)
            this.BulletBonuses.push(new c0(this))
            // Random damage bonus
            let c1 = RandomFromDictionary(Classes_BulletDamage)
            this.BulletBonuses.push(new c1(this))
            // Random extra bonuses
            let totalStrength = math.random(30, 40)
            while (totalStrength > 0) {
                let randomBonus = RandomFromDictionary(Classes_BulletExtra)
                let cls = new randomBonus(this)
                this.BulletBonuses.push(cls)
                totalStrength -= cls.Strength
            }
        }
    }
}
