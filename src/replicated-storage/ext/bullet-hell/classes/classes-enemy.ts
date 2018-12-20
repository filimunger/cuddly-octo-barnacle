import { SetPartCollisionGroup } from '../main/collision-groups'
import { MapWidthRadius, MapHeightRadius } from '../main/module'
import { Character, T_Character } from './classes'
import { T_Deck, T_DeckName, Classes_Deck } from './classes-deck'
import { Workspace } from 'rbx-services'
import { WeldModel } from '../../msc/helper-functions'

let createDeck = (name: T_DeckName, character: T_Character) => {
    return new Classes_Deck[name](character)
}

class Character_Enemy extends Character {
    Deck: T_Deck
    TakeDamage(damage: number) {
        this.Health -= damage
        if (this.Health <= 0) {
            this.Model.Destroy()
        }
    }
    Play() {
        this.Deck.Play()
    }
    constructor(name: string) {
        super(name)
        this.Model.Parent = Workspace.WaitForChild('EnemyCharacters')
        for (let instance of this.Model.GetDescendants()) {
            if (instance.IsA('BasePart')) {
                SetPartCollisionGroup(instance, 'EnemyCharacters')
            }
        }
        WeldModel(this.Model)
        this.Model.SetPrimaryPartCFrame(new CFrame(new Vector3(math.random(-MapWidthRadius, MapWidthRadius), 0, -MapHeightRadius - 10)))
        this.SetVelocity(new Vector3(0, 0, 10))
    }
}
export type T_EnemyCharacter = Character_Enemy
export type T_EnemyName = keyof typeof Classes_Enemy

export namespace Classes_Enemy {
    export class Noid extends Character_Enemy {
        Deck = createDeck('Noid', this)
    }
    export class ProceduralBoss extends Character_Enemy {
        Deck = createDeck('RandomizedBossDeck', this)
    }
}
