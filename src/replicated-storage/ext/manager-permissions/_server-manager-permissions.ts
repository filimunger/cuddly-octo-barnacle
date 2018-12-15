import { Players } from 'rbx-services'
import { T_Rank } from './manager-permissions'

export let SetPlayerRank = (player: Player, rank: T_Rank) => ((player.WaitForChild('Rank') as StringValue).Value = rank)

Players.PlayerAdded.Connect(function(player) {
    let value = new StringValue(player)
    value.Name = 'Rank'
    value.Value = 'Player'
})
