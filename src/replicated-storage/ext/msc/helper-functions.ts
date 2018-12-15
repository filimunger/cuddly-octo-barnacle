import { ReplicatedStorage } from 'rbx-services'

let ConvertVariable: any
ConvertVariable = (variable: any, parent?: Instance) => {
    let t = typeof variable
    let v: any
    if (t === 'string') {
        v = new StringValue(parent)
    } else if (t === 'boolean') {
        v = new BoolValue(parent)
    } else if (t === 'number') {
        v = new NumberValue(parent)
    } else if (variable instanceof Instance) {
        v = new ObjectValue(parent)
    } else if (variable instanceof Color3) {
        v = new Color3Value(parent)
    } else if (variable instanceof Vector3) {
        v = new Vector3Value(parent)
    } else {
        if (typeof variable === 'object') {
            return ConvertVariable(variable[1], parent)
        } else {
            warn('Couldnt assign variable value |', variable)
            return new BoolValue()
        }
    }
    v.Value = variable
    return v
}

export let VariableValue = (variable: any, parent?: Instance, name?: string): any => {
    let v = ConvertVariable(variable, parent)
    v.Name = name ? name : 'VariableValue'
    return v
}

export let CreateCompoundedValue = (variable: number | string, parent?: Instance, name?: string) => {
    let baseValue = VariableValue(variable, parent, name) as NumberValue | StringValue
    let reAssign = () => {
        let factor
        if (typeof variable === 'number') {
            factor = variable
            for (let child of baseValue.GetChildren()) {
                if (child.Name === 'Multiply') {
                    factor = factor * (child as NumberValue).Value
                }
            }
            for (let child of baseValue.GetChildren()) {
                if (child.Name === 'Add') {
                    factor = factor + (child as NumberValue).Value
                }
            }
        } else {
            factor = variable
            for (let child of baseValue.GetChildren()) {
                if (child.Name === 'Set') {
                    factor = (child as StringValue).Value
                }
            }
        }
        baseValue.Value = factor
    }
    baseValue.ChildAdded.Connect(reAssign)
    return baseValue
}

// Possible character starters: + * >
export let ModifyCompoundedValue = (value: Instance, modifyString: string) => {
    let firstCharacter = modifyString.sub(1, 1)
    let factor = tonumber(modifyString.gsub(firstCharacter, ''))
    let myValue = new NumberValue(value)
    myValue.Value = factor ? factor : 1
    myValue.Name = firstCharacter === '+' ? 'Add' : firstCharacter === '*' ? 'Multiply' : 'Set'
    return myValue
}

export let CustomCheckTypeOf = (element: any, string: 'Userdata' | 'EnumItem') => {
    return typeof element === (string as any)
}

export let ScaleModel = (model: Model, scaling: number) => {
    let scaleCFrame = (frame: CFrame) => {
        let [a, b, c, c0, c1, c2, c3, c4, c5, c6, c7, c8] = frame.components()
        return new CFrame(frame.p.mul(scaling)).mul(new CFrame(0, 0, 0, c0, c1, c2, c3, c4, c5, c6, c7, c8))
    }
    for (let instance of model.GetDescendants()) {
        if (instance.IsA('BasePart')) {
            let frame = instance.CFrame
            instance.Size = instance.Size.mul(scaling)
            instance.CFrame = scaleCFrame(frame)
        } else if (instance.IsA('Attachment')) {
            instance.Position = instance.Position.mul(scaling)
        } else if (instance.IsA('Motor6D')) {
            instance.Transform = scaleCFrame(instance.Transform)
        } else if (instance.IsA('ParticleEmitter')) {
            let nKeyPoints = instance.Size.Keypoints as any[]
            let keyPoints: NumberSequenceKeypoint[] = []
            for (let index = 0; index < nKeyPoints.length; index++) {
                const element = nKeyPoints[index]
                keyPoints[index] = new NumberSequenceKeypoint(element.Time, element.Value * scaling, element.Envelope * scaling)
            }
            instance.Size = new NumberSequence(keyPoints)
            instance.Speed = new NumberRange(instance.Speed.Min * scaling, instance.Speed.Max * scaling)
        }
    }
}

export let DeepCopy = (object: any) => {
    let clone = {}
    let search: any
    search = (directory: any, pair: any) => {
        for (let index in directory) {
            let element = directory[index]
            if (typeof element === 'object') {
                if (!pair[index]) {
                    pair[index] = {}
                }
                search(element, pair[index])
            } else {
                pair[index] = element
            }
        }
    }
    search(object, clone)
    return clone
}

export let ObjectArrayLength = (object: any) => {
    let count = 0
    for (let index in object) {
        count++
    }
    return count
}

export let PackData = (data: { [index: string]: any }) => {
    let search: any
    search = (directory: any) => {
        for (let index in directory) {
            let element = directory[index]
            if (element instanceof Color3) {
                directory[index] = ['%Color', element.r, element.g, element.b]
            } else if (element instanceof Vector3) {
                directory[index] = ['%Vector', element.X, element.Y, element.Z]
            } else if (typeof element === 'object') {
                search(element)
            }
        }
    }
    search(data)
    return data
}

export let UnpackData = (data: { [index: string]: any }) => {
    let search: any
    search = (directory: any) => {
        for (let index in directory) {
            let element = directory[index]
            if (typeof element === 'object') {
                let newElement = element as any[]
                if (newElement[0] === '%Color') {
                    directory[index] = new Color3(newElement[1], newElement[2], newElement[3])
                } else if (newElement[0] === '%Vector') {
                    directory[index] = new Vector3(newElement[1], newElement[2], newElement[3])
                } else {
                    search(newElement)
                }
            }
        }
    }
    search(data)
}

export let BringElementToFront = (array: any[], element: any) => {
    let index = array.indexOf(element)
    if (index > -1) {
        let old = array[0]
        array[0] = array[index]
        array[index] = old
    }
    return array
}

export let ConvertObjectToArray = (object: {}) => {
    let array = []
    for (let index in object) {
        array.push((object as any)[index])
    }
    return array
}

export let MaterialList = (str?: string) => {
    let t = ['Plastic', 'Wood', 'Slate', 'Concrete', 'CorrodedMetal', 'DiamondPlate', 'Foil', 'Grass', 'Ice', 'Marble', 'Granite', 'Brick', 'Pebble', 'Sand', 'Fabric', 'SmoothPlastic', 'Metal', 'WoodPlanks', 'Cobblestone']
    if (str) {
        BringElementToFront(t, str)
    }
    return t
}

export let EnumString = (e: any) => {
    let str = tostring(e)
    for (let i = str.length; i > 0; i--) {
        if (str.sub(i, i) === '.') {
            return str.sub(i + 1, str.length)
        }
    }
    warn('Failed to enum string')
    return ''
}

export let Round = (number: number, value?: number) => {
    if (!value || value === 1) {
        return math.floor(number + 0.5)
    } else {
        return math.floor(number / value + 0.5) * value
    }
}

export let AlignVectorToGrid = (vector: Vector3, value?: number, ignoreY?: boolean) => {
    return new Vector3(Round(vector.X, value), ignoreY ? vector.Y : Round(vector.Y, value), Round(vector.Z, value))
}

export let RecursiveSearchInstance: any
RecursiveSearchInstance = (search: Instance, name: string) => {
    if (search.Name === name) {
        return search
    }
    for (let child of search.GetChildren()) {
        let found = RecursiveSearchInstance(child, name)
        if (found) {
            return found
        }
    }
}
export let CreateNewEffect = (effectName: string, parent?: Instance) => {
    let effects = ReplicatedStorage.WaitForChild('Effects')
    let search = RecursiveSearchInstance(effects, effectName)
    if (search) {
        let clone = (search as Instance).Clone()
        clone.Parent = parent
        return clone
    }
}

export let CreateClass = <T extends new () => any, C extends InstanceType<T>>(cs: T, properties?: { [index in keyof C]?: C[keyof C] }): C => {
    let newClass = new cs()
    if (properties) for (let index in properties) newClass[index] = properties[index]
    return newClass
}

export let SimpleVector = (vect: Vector3) => {
    return new Vector3(vect.X, 0, vect.Z)
}
export let SimpleMagnitude = (vect0: Vector3, vect1: Vector3) => {
    return SimpleVector(vect0).sub(SimpleVector(vect1)).Magnitude
}