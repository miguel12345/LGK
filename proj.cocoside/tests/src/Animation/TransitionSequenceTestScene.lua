local TestScene = class("TransitionSequenceTestScene",function()
    return require("TestScene").create({
        description = "Layout transition sequence";
        contentXML = "TransitionSequenceTestScene"
    })
end)

function TestScene:animate()
    
    local transition = self.transitionSequence
   
    if transition:isDone() or transition:isReversed() then
    	transition:reverse()
    end
    
    transition:run()
end

function TestScene.create()
    local scene = TestScene.new()
    
    local animatableElement = scene.elements["animatableElement"]
    scene.transition1 = lgk.Transition:create(animatableElement)

    scene.transition1:setInitialStateCallback(function(widget)
        local relativeParameter = widget:getLayoutParameter()
        local align = relativeParameter:getAlign()
        if align ~= ccui.RelativeAlign.alignParentTopLeft then
            relativeParameter:setAlign(ccui.RelativeAlign.alignParentTopLeft)
            widget:layoutParameterChanged()
        end
    end)

    scene.transition1:setFinalStateCallback(function(widget)
        local relativeParameter = widget:getLayoutParameter()
        local align = relativeParameter:getAlign()
        if align ~= ccui.RelativeAlign.alignParentLeftBottom then
            relativeParameter:setAlign(ccui.RelativeAlign.alignParentLeftBottom)
            widget:layoutParameterChanged()
        end
    end)
    
    local animatableElement2 = scene.elements["animatableElement2"]
    scene.transition2 = lgk.Transition:create(animatableElement2)

    scene.transition2:setInitialStateCallback(function(widget)
        local relativeParameter = widget:getLayoutParameter()
        local align = relativeParameter:getAlign()
        if align ~= ccui.RelativeAlign.alignParentTopCenterHorizontal then
            relativeParameter:setAlign(ccui.RelativeAlign.alignParentTopCenterHorizontal)
            widget:layoutParameterChanged()
        end
    end)

    scene.transition2:setFinalStateCallback(function(widget)
        local relativeParameter = widget:getLayoutParameter()
        local align = relativeParameter:getAlign()
        if align ~= ccui.RelativeAlign.alignParentBottomCenterHorizontal then
            relativeParameter:setAlign(ccui.RelativeAlign.alignParentBottomCenterHorizontal)
            widget:layoutParameterChanged()
        end
    end)
    
    
    local animatableElement3 = scene.elements["animatableElement3"]
    scene.transition3 = lgk.Transition:create(animatableElement3)

    scene.transition3:setInitialStateCallback(function(widget)
        local relativeParameter = widget:getLayoutParameter()
        local align = relativeParameter:getAlign()
        if align ~= ccui.RelativeAlign.alignParentTopRight then
            relativeParameter:setAlign(ccui.RelativeAlign.alignParentTopRight)
            widget:layoutParameterChanged()
        end
    end)

    scene.transition3:setFinalStateCallback(function(widget)
        local relativeParameter = widget:getLayoutParameter()
        local align = relativeParameter:getAlign()
        if align ~= ccui.RelativeAlign.alignParentRightBottom then
            relativeParameter:setAlign(ccui.RelativeAlign.alignParentRightBottom)
            widget:layoutParameterChanged()
        end
    end)
    
    scene.transitionSequence = lgk.TransitionSequence:create({scene.transition1,scene.transition2,scene.transition3})
    
    scene.execute = function(self)
        
    end
    
    return scene
end


return TestScene