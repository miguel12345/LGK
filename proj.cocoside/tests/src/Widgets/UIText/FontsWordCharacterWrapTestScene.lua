local TestScene = class("FontsWordCharacterWrapTestScene",function()
    return require("TestScene").create({
        description = "Text wrapping";
        contentXML = "FontsWordCharacterWrapTestScene"
    })
end)

function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        
    end
    
    return scene
end


return TestScene