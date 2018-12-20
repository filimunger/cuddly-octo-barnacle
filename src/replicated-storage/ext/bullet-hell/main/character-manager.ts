import { Friendlies, Enemies } from './class-storage'

// Note: these helper functions return as any, and fixing it would cause infinite recursions

export const GetEnemyFromPart = (part: Instance) => {
    let parent = part.Parent
    for (let character of Enemies) {
        if (character.Model === parent) {
            return character
        }
    }
}

export const GetFriendlyFromPart = (part: Instance) => {
    let parent = part.Parent
    for (let character of Friendlies) {
        if (character.Model === parent) {
            return character
        }
    }
}

export const GetFriendlyForPlayer = (player: Player) => {
    for (let character of Friendlies) {
        if (character.Player === player) {
            return character
        }
    }
    warn('Failed to get client character')
    return undefined as any
}
