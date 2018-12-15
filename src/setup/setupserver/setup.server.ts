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

warn('Loading Game')
let extensions = ReplicatedStorage.ext
BuildOrder.forEach(name => {
    let directory = extensions.FindFirstChild(name)
    if (directory) {
        warn('Loading directory |', directory.Name)
        directory.GetChildren().forEach(function(v) {
            if (v instanceof ModuleScript) {
                if (v.Name.find('_server')) {
                    warn('req :: ', v.Name)
                    require(v as any)
                }
            }
        })
    } else {
        warn('Failed to load directory | ', name)
    }
})
