lgk = lgk or {}

local LGKScene = class("LGKScene",function()
    return cc.Scene:create()
end)

function LGKScene.create(name)
    local scene = LGKScene.new()
    scene:setName(name)
    scene.elements = setmetatable({}, {__mode="v"})
    scene:addChild(require("generated_lgx."..name.."_lgx")(scene,scene.elements))
    return scene
end

function LGKScene.getSceneClass(name)
    return class(name,function()
        return LGKScene.create(name)
    end)
end

lgk.LGKScene = LGKScene