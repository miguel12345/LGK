local TestScene = class("TransitionSingleCompletionCallbackTestScene",function()
    return require("TestScene").create({
        description = "Layout transitions finish callback";
        contentXML = "TransitionSingleCompletionCallbackTestScene"
    })
end)

function TestScene:animate()
    
    local transition = self.transition1

    if transition:isDone() or transition:isReversed() then
        transition:reverse()
    end

    local animationFinishText = self.elements["animationFinished"]
    animationFinishText:setOpacity(0)
    transition:run()
    
end

function TestScene.create()
    local scene = TestScene.new()
    
    local animatableElement = scene.elements["animatableElement"]
    scene.transition1 = lgk.Transition:create(animatableElement)

    scene.transition1:setInitialStateCallback(function(widget)
        local relativeParameter = widget:getLayoutParameter()
        local align = relativeParameter:getAlign()
        relativeParameter:setAlign(ccui.RelativeAlign.alignParentTopLeft)
        widget:layoutParameterChanged()
    end)

    scene.transition1:setFinalStateCallback(function(widget)
        local relativeParameter = widget:getLayoutParameter()
        local align = relativeParameter:getAlign()
        relativeParameter:setAlign(ccui.RelativeAlign.alignParentRightBottom)
        widget:layoutParameterChanged()
    end)
    
    scene.transition1:setCompletionCallback(function()
        local animationFinishText = scene.elements["animationFinished"]
        animationFinishText:setOpacity(255)
    end)
    
    scene.execute = function(self)
        
    end
    
    return scene
end


return TestScene