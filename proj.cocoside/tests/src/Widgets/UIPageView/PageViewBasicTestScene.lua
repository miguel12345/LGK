local TestScene = class("PageViewBasicTestScene",function()
    return require("TestScene").create({
        description = "PageView Basic Test Scene";
        contentXML = "PageViewBasicTestScene"
    })
end)

function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        
    end

    
    return scene
end


return TestScene