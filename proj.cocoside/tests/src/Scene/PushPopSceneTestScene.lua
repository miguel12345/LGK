local TestScene = class("PushPopSceneTestScene",function()
    return require("TestScene").create({
        description = "Push/Pop scene";
        contentXML = "PushPopSceneTestScene"
    })
end)

function TestScene:goToNextScene()
    lgk.LGKScene.pushScene("PushPopSceneTestScene2")
end

function TestScene.create()
    local scene = TestScene.new()

    
    scene.execute = function(self)
    end
    
    return scene
end


return TestScene