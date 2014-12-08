local TestScene = class("FontsTestScene",function()
    return require("TestScene").create({
        description = "Fonts Test";
        contentXML = "FontsTestScene"
    })
end)

function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        local bottomTopBoundary = self.elements["bottom"]:getTopBoundary();
        local centerBottomBoundary = self.elements["center"]:getBottomBoundary();
        
        testassert(bottomTopBoundary==centerBottomBoundary,"Bottom element shoud be aligned to the bottom of the centered element")
        
    end
    
    return scene
end


return TestScene