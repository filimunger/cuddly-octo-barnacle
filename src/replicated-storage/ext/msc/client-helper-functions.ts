import { Workspace, Players } from 'rbx-services'

let player = Players.LocalPlayer as Player
let mouse = player.GetMouse()
let defaultIgnoreList: Instance[] = [Workspace.WaitForChild('Characters')]
export const GetCursorPosition = (ignoreList: Instance[] = []): [Vector3, BasePart] => {
    let ray = Workspace.CurrentCamera.ScreenPointToRay(mouse.X, mouse.Y)
    ray = new Ray(ray.Origin, ray.Unit.Direction.mul(999))
    let [hit, hitPosition] = Workspace.FindPartOnRayWithIgnoreList(ray, ignoreList.concat(defaultIgnoreList), true, false)
    let cframe = new CFrame(hitPosition, hitPosition.add(ray.Unit.Direction))
    return [cframe.p, hit]
}
