import { Classes_Enemy, T_EnemyCharacter, T_EnemyName } from '../classes/classes-enemy'
import { T_FriendlyName, Classes_Friendly, T_FriendlyCharacter } from '../classes/classes-friendly'

let enemies: T_EnemyCharacter[] = []
export let CreateEnemy = (name: T_EnemyName) => {
    let cls = new Classes_Enemy[name](name) as T_EnemyCharacter
    enemies.push(cls)
    cls.Play()
}
export let GetEnemyFromPart = (part: Instance) => {
    let parent = part.Parent
    for (let character of enemies) {
        if (character.Model === parent) {
            return character
        }
    }
}

let friendlies: T_FriendlyCharacter[] = []
export let CreateFriendly = (name: T_FriendlyName, player: Player) => {
    let friendlyCharacter = new Classes_Friendly[name](name, player)
    friendlies.push(friendlyCharacter)
}

export let GetFriendlyFromPart = (part: Instance) => {
    let parent = part.Parent
    for (let character of friendlies) {
        if (character.Model === parent) {
            return character
        }
    }
}

export let GetFriendlyCharacter = (player: Player) => {
    for (let character of friendlies) {
        if (character.Player === player) {
            return character
        }
    }
    warn('Failed to get client character')
    return (undefined as any) as T_FriendlyCharacter
}
