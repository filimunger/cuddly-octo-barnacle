import { ReplicatedStorage } from 'rbx-services'
import { BuildOrder } from '../../replicated-storage/build-order'
wait(2)
warn('Loading Client Game')
let extensions = ReplicatedStorage.ext
BuildOrder.forEach(name => {
    let directory = extensions.FindFirstChild(name)
    if (directory) {
        warn('Loading client directory |', directory.Name)
        directory.GetChildren().forEach(function(v) {
            if (v instanceof ModuleScript) {
                if (v.Name.find('_client')) {
                    warn('req :: ', v.Name)
                    require(v as any)
                }
            }
        })
    } else {
        warn('Failed to load client directory | ', name)
    }
})
