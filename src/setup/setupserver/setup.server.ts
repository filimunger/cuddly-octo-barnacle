import { ReplicatedStorage, Workspace, ServerStorage } from 'rbx-services'
import { BuildOrder } from '../../replicated-storage/build-order'

let serverDirectory = Workspace.FindFirstChild('ServerStorage')
if (serverDirectory) {
    for (let object of serverDirectory.GetChildren()) {
        object.Parent = ServerStorage
    }
}
let replicatedDirectory = Workspace.FindFirstChild('ReplicatedStorage')
if (replicatedDirectory) {
    for (let object of replicatedDirectory.GetChildren()) {
        object.Parent = ReplicatedStorage
    }
}
if (Workspace.FindFirstChild('Bin')) {
    Workspace.Bin.Destroy()
}

let src: any
src = (v: Instance) => {
    if (v.IsA('Folder')) {
        v.GetChildren().forEach(src)
    }
    if (v.IsA('ModuleScript')) {
        if (v.Name.find('_server')) {
            warn('require :: ', v.Name)
            require(v as any)
        }
    }
}

warn('Loading Game')
let extensions = ReplicatedStorage.ext
BuildOrder.forEach(name => {
    let directory = extensions.FindFirstChild(name)
    if (directory) {
        warn('Loading server directory |', directory.Name)
        src(directory)
    } else {
        warn('Failed to load directory | ', name)
    }
})
