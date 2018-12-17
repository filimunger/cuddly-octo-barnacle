import { Players, Workspace, ReplicatedFirst, ReplicatedStorage } from 'rbx-services'

import { EngageRemoteObject } from '../../manager-remote/manager-remote'
import { MapHeightRadius, MapWidthRadius } from './module'
import { GetModelCFrame } from '../../msc/helper-functions'
import { SetPartCollisionGroup } from './collision-groups'
import { GetFriendlyForPlayer } from './character-manager'
import { CreateEnemy, CreateFriendly } from './character-creation'

export = true

let friendlyCharacters = new Model(Workspace)
friendlyCharacters.Name = 'FriendlyCharacters'
let enemyCharacters = new Model(Workspace)
enemyCharacters.Name = 'EnemyCharacters'
let friendlyData = new Model(Workspace)
friendlyData.Name = 'FriendlyData'

for (let character of ReplicatedStorage.WaitForChild('Effects')
    .WaitForChild('Characters')
    .WaitForChild('FriendlyCharacters')
    .GetChildren()) {
    let modelCFrame = GetModelCFrame(character as Model)
    for (let instance of character.GetDescendants()) {
        if (instance.IsA('Attachment')) {
            let part = instance.Parent as Instance
            let mirror = (part.Parent as Instance).FindFirstChild(part.Name + '_Mirror')
            if (mirror) {
                let clone = instance.Clone() as Attachment
                clone.Parent = mirror
            }
        }
    }
}

for (let set of [[-1, 0], [0, 1], [0, -1], [1, 0]]) {
    let x = set[0]
    let y = set[1]
    let wall = new Part(Workspace)
    wall.Anchored = true
    wall.Size = new Vector3(x === 0 ? MapWidthRadius * 2 : 0, 100, y === 0 ? MapHeightRadius * 2 : 0)
    wall.CFrame = new CFrame(new Vector3(MapWidthRadius * x, 0, MapHeightRadius * y))
    wall.Transparency = 1
    SetPartCollisionGroup(wall, 'EnemyBullets')
}

Players.PlayerAdded.Connect(player => {
    CreateFriendly('Plane', player)
})

let ManagedRemotes = {
    CharacterSteer: (player: Player | undefined, x: number, y: number, steady?: boolean) => {
        if (player) {
            GetFriendlyForPlayer(player).Steer(x, y, steady)
        }
    },
    CharacterFire: (player: Player | undefined, bool: boolean) => {
        if (player) {
            GetFriendlyForPlayer(player).Fire(bool)
        }
    },
}
EngageRemoteObject(ManagedRemotes)

while (true) {
    CreateEnemy('Noid')
    wait(3)
}
