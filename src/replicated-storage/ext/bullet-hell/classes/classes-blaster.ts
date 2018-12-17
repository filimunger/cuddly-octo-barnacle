import { T_Bullet, T_BulletName, Classes_Bullet } from './classes-bullet'
import { T_Character } from './classes'
import { RandomIndexFromDictionary } from '../../msc/helper-functions'

let createBullet = (bulletName: T_BulletName, blaster: T_Blaster) => {
    let cls = new Classes_Bullet[bulletName]()
    blaster.Bullets.push(cls)
    return cls
}

class Blaster {
    AreaId: number = 0
    Attachments: Attachment[] = []
    Bullets: T_Bullet[] = []
    Fire() {
        for (let attachment of this.Attachments) {
            for (let bullet of this.Bullets) {
                bullet.Fire(attachment.WorldCFrame)
            }
        }
    }
    constructor(character: T_Character) {
        for (let instance of character.Model.GetDescendants()) {
            if (instance.IsA('Attachment')) {
                if (instance.Name === 'Attachment_Turret' + tostring(this.AreaId)) {
                    this.Attachments.push(instance)
                }
            }
        }
    }
}
export type T_Blaster = Blaster
export type T_BlasterName = keyof typeof Classes_Blaster

export namespace Classes_Blaster {
    export class SimpleBlaster extends Blaster {
        AreaId = 0
        constructor(character: T_Character) {
            super(character)
            createBullet('SimpleBullet', this)
        }
    }

    export class BombBlaster extends Blaster {
        AreaId = 1
    }
    export class RandomizedBlaster extends Blaster {
        AreaId = math.random(0, 3)
        constructor(character: T_Character) {
            super(character)
            this.Bullets.push(new Classes_Bullet[(RandomIndexFromDictionary(Classes_Bullet))]())
            if (math.random(1, 10) === 1) {
                this.Bullets.push(new Classes_Bullet[(RandomIndexFromDictionary(Classes_Bullet))]())
            }
        }
    }
    export class SuperRandomizedBlaster extends Blaster {
        constructor(character: T_Character) {
            super(character)
            createBullet('RandomBullet', this)
            if (math.random(1, 10) === 1) {
                createBullet('RandomBullet', this)
            }
        }
    }
}
