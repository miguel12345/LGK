local TestScene = class("GradientsColorTestScene",function()
    return require("TestScene").create({
        description = "Gradients Test";
        contentXML = "GradientsColorTestScene"
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