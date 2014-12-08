local TestScene = class("RelativeLayoutTestScene",function()
    return require("TestScene").create({
        description = "Relative Layout Test";
        contentXML = "RelativeLayoutTestScene"
    })
end)

function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        assert(true)
    end
    
    return scene
end


return TestScene