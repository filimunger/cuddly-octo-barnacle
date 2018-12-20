export const InputCodes = { Attack: [Enum.UserInputType.MouseButton1, Enum.KeyCode.Z], Bomb: [Enum.UserInputType.MouseButton2, Enum.KeyCode.X], Move_Up: [Enum.KeyCode.W, Enum.KeyCode.Up], Move_Left: [Enum.KeyCode.A, Enum.KeyCode.Left], Move_Down: [Enum.KeyCode.S, Enum.KeyCode.Down], Move_Right: [Enum.KeyCode.D, Enum.KeyCode.Right], Move_Steady: [Enum.KeyCode.LeftShift] }
export type T_InputCodes = typeof InputCodes
export type T_InputNames = keyof T_InputCodes
