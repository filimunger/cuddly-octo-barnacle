export let InputCodes = { MouseClick: Enum.UserInputType.MouseButton1, Ability1: Enum.KeyCode.R, Ability2: Enum.KeyCode.F, Ability3: Enum.KeyCode.V, TogglePlacementMenu: Enum.KeyCode.Q, ClosePlacementMenu: Enum.KeyCode.E }
export type T_InputCodes = typeof InputCodes
export type T_InputNames = keyof T_InputCodes
