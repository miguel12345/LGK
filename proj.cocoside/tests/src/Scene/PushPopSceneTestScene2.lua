local TestScene = class("PushPopSceneTestScene2",function()
    return cc.Scene:create()
end)

function TestScene:goToPreviousScene()
    lgk.LGKScene.popScene()
end

function TestScene.create()
    local scene = TestScene.new()
    scene.elements = setmetatable({}, {__mode="v"})
    scene:addChild(require("generated_lgx.PushPopSceneTestScene2_lgx")(scene,scene.elements))

    return scene
end


return TestScene