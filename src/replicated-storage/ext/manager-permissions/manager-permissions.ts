import { Players } from 'rbx-services'

export let RankObject = { Player: 0, Editor: 1, Host: 2 }
type T_RankObject = typeof RankObject
export type T_Rank = keyof T_RankObject
export type T_RankId = T_RankObject[T_Rank]

export let ManageGameRank: T_Rank = 'Editor'
export let EditRanksRank: T_Rank = 'Player'

export function GetRankId(rank: T_Rank): T_RankId {
    return RankObject[rank]
}

export function GetPlayerRank(player: Player): T_Rank {
    let rankObject = player.WaitForChild('Rank') as StringValue
    return rankObject.Value as T_Rank
}

export function RankExceedsRank(myRank: T_Rank, rank: T_Rank) {
    return GetRankId(myRank) >= GetRankId(rank)
}

export function PlayerExceedsRank(player: Player, rank: T_Rank) {
    return RankExceedsRank(GetPlayerRank(player), rank)
}

export function BindElementToRank(element: GuiObject, rank: T_Rank = ManageGameRank, hideWhileLostRank: boolean = true, clickCallback?: () => void, lostRankCallback?: () => void, regainedRankCallback?: () => void) {
    let player = Players.LocalPlayer as Player
    let rankObject = player.WaitForChild('Rank') as StringValue
    let connection: RBXScriptConnection | undefined
    function update() {
        if (PlayerExceedsRank(player, rank)) {
            if (hideWhileLostRank) element.Visible = true
            if (regainedRankCallback) regainedRankCallback()
            if (clickCallback && element instanceof ImageButton) connection = element.MouseButton1Down.Connect(clickCallback)
        } else {
            if (hideWhileLostRank) element.Visible = false
            if (connection) connection.Disconnect()
            if (lostRankCallback) lostRankCallback()
        }
    }
    update()
    rankObject.Changed.Connect(update)
}
