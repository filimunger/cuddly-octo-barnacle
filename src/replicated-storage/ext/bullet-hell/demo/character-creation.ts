import { Classes_Enemy, T_EnemyCharacter, T_EnemyName } from '../classes/classes-enemy'
import { T_FriendlyName, Classes_Friendly, T_FriendlyCharacter } from '../classes/classes-friendly'
import { Enemies, Friendlies } from './friendly-enemy-storage'

export let CreateEnemy = (name: T_EnemyName) => {
    let cls = new Classes_Enemy[name](name) as T_EnemyCharacter
    Enemies.push(cls)
    cls.Play()
}
export let CreateFriendly = (name: T_FriendlyName, player: Player) => {
    let friendlyCharacter = new Classes_Friendly[name](name, player)
    Friendlies.push(friendlyCharacter)
}
