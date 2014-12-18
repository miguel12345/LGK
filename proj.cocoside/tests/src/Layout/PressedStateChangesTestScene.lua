local TestScene = class("PressedBackgroundColorTestScene",function()
    return require("TestScene").create({
        description = "Pressed background color";
        contentXML = "PressedStateChangesTestScene"
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
        local textColor = self.elements["text"]:getVirtualRenderer():getTextColor()
        testassert(elementBackgroundColor.r==0 and elementBackgroundColor.g==255 and elementBackgroundColor.b==0,"The element with pressed backgroundColor set to green must be green when pressing down on it")
        testassert(textColor.r==255 and textColor.g==0 and textColor.b==0,"The text with pressed textColor set to red must be red when pressing down on it")
        cc.Director:getInstance():getOpenGLView():simulatePressUp()
        elementBackgroundColor = element:getBackGroundColor()
        textColor = self.elements["text"]:getVirtualRenderer():getTextColor()
        testassert(elementBackgroundColor.r==255 and elementBackgroundColor.g==0 and elementBackgroundColor.b==0,"The element with backgroundColor set to red must be red when NOT pressing down on it")
        testassert(textColor.r==0 and textColor.g==255 and textColor.b==0,"The text with textColor set to green must be green when pressing down on it")
    end
    
    return scene
end


return TestScene