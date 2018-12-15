import { UserInputService } from 'rbx-services'
import { T_InputNames, InputCodes } from './input-codes'

type T_InputCache = [Enum.KeyCode | Enum.UserInputType | Array<Enum.KeyCode | Enum.UserInputType> | T_InputNames, (() => void) | undefined, (() => void)?]
export function BindInputs(...a: T_InputCache[]): [RBXScriptConnection | undefined, RBXScriptConnection | undefined] {
    function search(bool: boolean, input: InputObject) {
        a.forEach(function(t) {
            if ((bool && !t[1]) || (!bool && !t[2])) {
                return
            }
            if (input.KeyCode === t[0] || input.UserInputType === t[0]) {
                let fn = t[bool ? 1 : 2]
                if (fn) {
                    fn()
                }
            }
            if (typeof t[0] === 'string') {
                let supposedKey = InputCodes[t[0]]
                if (input.KeyCode === supposedKey || input.UserInputType === supposedKey) {
                    let fn = t[bool ? 1 : 2]
                    if (fn) {
                        fn()
                    }
                }
            }
        })
    }
    let foundFirstFunction = false,
        foundSecondFunction = false
    for (let set of a) {
        if (set[1]) {
            foundFirstFunction = true
        }
        if (set[2]) {
            foundSecondFunction = true
        }
        if (foundFirstFunction && foundSecondFunction) {
            break
        }
    }
    let connection1, connection2
    if (foundFirstFunction) {
        connection1 = UserInputService.InputBegan.Connect(function(input, gameProcessed) {
            if (!gameProcessed) {
                search(true, input)
            }
        })
    }
    if (foundSecondFunction) {
        connection2 = UserInputService.InputEnded.Connect(function(input) {
            search(false, input)
        })
    }
    return [connection1, connection2]
}

BindInputs(['Ability1', () => {}])
