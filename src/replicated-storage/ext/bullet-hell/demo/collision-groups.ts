import { PhysicsService } from 'rbx-services'

let collisionGroups = {
    FriendlyCharacters: [],
    EnemyCharacters: [],
    FriendlyBullets: [],
    EnemyBullets: [],
}
type T_CollisionGroupName = keyof typeof collisionGroups
for (let name in collisionGroups) {
    PhysicsService.CreateCollisionGroup(name)
}
export let SetPartCollisionGroup = (part: BasePart, name: T_CollisionGroupName) => {
    PhysicsService.SetPartCollisionGroup(part, name)
}
let collisionGroupsSetCollidable = (name0: T_CollisionGroupName, name1: T_CollisionGroupName, bool: boolean) => {
    PhysicsService.CollisionGroupSetCollidable(name0, name1, bool)
}
collisionGroupsSetCollidable('FriendlyCharacters', 'FriendlyBullets', false)
collisionGroupsSetCollidable('EnemyCharacters', 'EnemyBullets', false)
collisionGroupsSetCollidable('FriendlyCharacters', 'FriendlyCharacters', false)
collisionGroupsSetCollidable('EnemyCharacters', 'EnemyCharacters', false)
collisionGroupsSetCollidable('EnemyCharacters', 'FriendlyCharacters', false)
collisionGroupsSetCollidable('EnemyBullets', 'FriendlyBullets', false)
collisionGroupsSetCollidable('EnemyBullets', 'EnemyBullets', false)
