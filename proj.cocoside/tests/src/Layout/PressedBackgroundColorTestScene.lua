local TestScene = class("PressedBackgroundColorTestScene",function()
    return require("TestScene").create({
        description = "Pressed background color";
        contentXML = "PressedBackgroundColorTestScene"
    })
end)

function TestScene.create()
    local scene = TestScene.new()

    
    scene.execute = function(self)
        local element = self.elements["element"]
        
        local winSize = cc.Director:getInstance():getWinSize()
        local x = winSize.width/2.0
        local y = winSize.height/2.0
        cc.Director:getInstance():getOpenGLView():simulatePressDown(x,y)
        local elementBackgroundColor = element:getBackGroundColor()
        testassert(elementBackgroundColor.r==0 and elementBackgroundColor.g==255 and elementBackgroundColor.b==0,"The element with pressedBackgroundColor set to green must be green when pressing down on it")
        cc.Director:getInstance():getOpenGLView():simulatePressUp()
        elementBackgroundColor = element:getBackGroundColor()
        testassert(elementBackgroundColor.r==255 and elementBackgroundColor.g==0 and elementBackgroundColor.b==0,"The element with backgroundColor set to red must be red when NOT pressing down on it")
    end
    
    return scene
end


return TestScene