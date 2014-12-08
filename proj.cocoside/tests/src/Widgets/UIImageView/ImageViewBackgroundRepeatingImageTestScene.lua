local TestScene = class("ImageViewBackgroundRepeatingImageTestScene",function()
    return require("TestScene").create({
        description = "ImageView background repeating image test";
        contentXML = "ImageViewBackgroundRepeatingImageTestScene"
    })
end)



function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        local backgroundRepeatingImage = self.elements["backgroundRepeatingImage"]
        testassert(backgroundRepeatingImage:getContentMode(),"Background image content mode is set to repeat")
    end
    
    return scene
end


return TestScene