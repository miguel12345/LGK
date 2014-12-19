local TestScene = class("PressedBackgroundColorTestScene",function()
    return require("TestScene").create({
        description = "Multiple touch actions";
        contentXML = "MultipleTouchActionsTestScene"
    })
end)

function TestScene:showHideElement()

    local showHideElement = self.elements["showHideElement"]
    
    if showHideElement:getOpacity() == 0 then
    	showHideElement:setOpacity(255)
    else
        showHideElement:setOpacity(0)
    end
end

function TestScene.create()
    local scene = TestScene.new()

    
    scene.execute = function(self)
    
        local element = self.elements["touchElement"]
        local showHideElement = self.elements["showHideElement"]
        
        showHideElement:setOpacity(0)
        
        local winSize = cc.Director:getInstance():getWinSize()
        local x = winSize.width/2.0
        local y = winSize.height/2.0
        
        cc.Director:getInstance():getOpenGLView():simulatePressDown(x,y)
        local elementBackgroundColor = element:getBackGroundColor()
        local showHideElementOpacity = showHideElement:getOpacity()
        testassert(elementBackgroundColor.r==0 and elementBackgroundColor.g==255 and elementBackgroundColor.b==0,"The element with pressed backgroundColor set to green must be green when pressing down on it")
        testassert(showHideElementOpacity==0,"The 'showHideElement' must be invisible before the tap on 'touchElement' completes")
        
        cc.Director:getInstance():getOpenGLView():simulatePressUp()
        elementBackgroundColor = element:getBackGroundColor()
        showHideElementOpacity = showHideElement:getOpacity()
        testassert(elementBackgroundColor.r==255 and elementBackgroundColor.g==0 and elementBackgroundColor.b==0,"The element with backgroundColor set to red must be red when NOT pressing down on it")
        testassert(showHideElementOpacity==255,"The 'showHideElement' must be visible after the tap on 'touchElement' completes")
    end
    
    return scene
end


return TestScene