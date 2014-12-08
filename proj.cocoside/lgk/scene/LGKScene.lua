lgk = lgk or {}

local LGKScene = class("LGKScene",function()
    return cc.Scene:create()
end)

function LGKScene.create(name)
    local scene = LGKScene.new()
    scene:setName(name)
    scene:addChild(lgk.LayoutInflater:inflateXMLFile(name .. ".xml",scene))
    return scene
end

function LGKScene.getSceneClass(name)
    return class(name,function()
        return LGKScene.create(name)
    end)
end

lgk.LGKScene = LGKScene