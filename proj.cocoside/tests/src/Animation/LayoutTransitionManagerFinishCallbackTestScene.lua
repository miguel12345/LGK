local TestScene = class("LayoutTransitionManagerFinishCallbackTestScene",function()
    return require("TestScene").create({
        description = "Layout transitions finish callback";
        contentXML = "LayoutTransitionManagerFinishCallbackTestScene"
    })
end)

function TestScene:animate()
    
    local animatableElement = self.elements["animatableElement"]
    local animationFinishText = self.elements["animationFinished"]
    
    animationFinishText:setOpacity(0)
    
    local transition = lgk.Transition:create(animatableElement)
    transition:setFinishedCallback(function()
        animationFinishText:setOpacity(255)
    end)
    
    local relativeParameter = animatableElement:getLayoutParameter()
    local relativeParameterAlign = relativeParameter:getAlign()
    relativeParameter:setAlign(relativeParameterAlign == ccui.RelativeAlign.alignParentLeftCenterVertical and ccui.RelativeAlign.alignParentRightBottom or ccui.RelativeAlign.alignParentLeftCenterVertical)
    animatableElement:setOpacity(animatableElement:getOpacity()==255 and 100 or 255)
    
    transition:run()
    
end

function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        
    end
    
    return scene
end


return TestScene