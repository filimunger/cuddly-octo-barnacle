import { Players } from 'rbx-services'
import { C } from '../manager-userinterface/userinterface-module'
import { AddInternalMenuButton } from '../manager-userinterface/_client-hub-menu'
import { RankObject, GetPlayerRank, PlayerExceedsRank, EditRanksRank, T_Rank } from './manager-permissions'
import { SetPlayerRank } from './_server-manager-permissions'
export = true

let menu = AddInternalMenuButton('Modify Permissions')
let labelHeight = 40
let container = C('Container', menu, { Style: 'Grid', CellSize: new UDim2(1, 0, 0, labelHeight) })

C('TypePanel', container, { Text: 'Set Permissions' })
let addPlayerToContainer = (player: Player) => {
    let panel = C('Panel', container, {})
    let nameWidth = 100
    C('TypePanel', panel, { Text: player.Name, Size: new UDim2(0, nameWidth, 1, 0) })
    let ranksPanel = C('Panel', panel, { Size: new UDim2(1, -nameWidth, 1, 0), Position: new UDim2(0, nameWidth, 0, 0) })
    let ranksContainer = C('Container', ranksPanel, { Style: 'Grid', CellSize: new UDim2(0, labelHeight, 0, labelHeight), HAlignment: 'Right' })
    for (let rankName in RankObject) {
        let rankButton = C('TypeButton', ranksContainer, { Text: rankName.sub(1, 1) })
        rankButton.MouseClick.Connect(() => {
            let myPlayer = Players.LocalPlayer as Player
            if (myPlayer !== player && PlayerExceedsRank(myPlayer, EditRanksRank) && PlayerExceedsRank(myPlayer, rankName as T_Rank)) {
                SetPlayerRank(player, rankName as T_Rank)
            }
        })
    }
    let rankLabel = C('TypePanel', panel, { Position: new UDim2(0, nameWidth, 0, 0), Size: new UDim2(1, -nameWidth, 1, 0) })
    let update = () => {
        rankLabel.Text = GetPlayerRank(player)
    }
    let rankValue = player.WaitForChild('Rank') as StringValue
    rankValue.Changed.Connect(update)
    update()
}
let removePlayerFromContainer = (player: Player) => {}

Players.GetPlayers().forEach(addPlayerToContainer)
Players.PlayerAdded.Connect(addPlayerToContainer)
Players.PlayerRemoving.Connect(removePlayerFromContainer)
