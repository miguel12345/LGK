lgk = lgk or {}

local layoutInflater = lgk.LayoutInflater

local XMLScene = {}

function XMLScene.sceneWithName(name)
    local scene = requiresafe(name).create() 
    scene:addChild(layoutInflater:inflateXMLFile(name .. ".xml",scene))
    return scene
end

lgk.XMLScene = XMLScene
