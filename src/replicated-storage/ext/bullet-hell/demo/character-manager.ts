import { Enemies, Friendlies } from './friendly-enemy-storage'

// Note: these helper functions return as any, and fixing it would cause infinite recursions

export let GetEnemyFromPart = (part: Instance) => {
    let parent = part.Parent
    for (let character of Enemies) {
        if (character.Model === parent) {
            return character
        }
    }
}

export let GetFriendlyFromPart = (part: Instance) => {
    let parent = part.Parent
    for (let character of Friendlies) {
        if (character.Model === parent) {
            return character
        }
    }
}

export let GetFriendlyForPlayer = (player: Player) => {
    for (let character of Friendlies) {
        if (character.Player === player) {
            return character
        }
    }
    warn('Failed to get client character')
    return undefined as any
}
