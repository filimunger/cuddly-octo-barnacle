import { ReplicatedStorage } from 'rbx-services'
import { BuildOrder } from '../../replicated-storage/build-order'
wait(0.5)
warn('Loading Client Game')
let extensions = ReplicatedStorage.ext

let src: any
src = (v: Instance) => {
    if (v.IsA('Folder')) {
        v.GetChildren().forEach(src)
    }
    if (v.IsA('ModuleScript')) {
        if (v.Name.find('_client')) {
            warn('require :: ', v.Name)
            require(v as any)
        }
    }
}

BuildOrder.forEach(name => {
    let directory = extensions.FindFirstChild(name)
    if (directory) {
        warn('Loading client directory |', directory.Name)
        src(directory)
    } else {
        warn('Failed to load directory | ', name)
    }
})
