local TestScene = class("LayoutTransitionManagerMultipleElementsTestScene",function()
    return require("TestScene").create({
        description = "Layout transitions with multiple elements";
        contentXML = "LayoutTransitionManagerMultipleElementsTestScene"
    })
end)

function TestScene:animate()
    
    local animatableElement = self.elements["animatableElement"]
    local animatableElement2 = self.elements["animatableElement2"]
    local animatableElement3 = self.elements["animatableElement3"]
    
    local transition = lgk.Transition:create(animatableElement,1)
    local transition2 = lgk.Transition:create(animatableElement2,1)
    local transition3 = lgk.Transition:create(animatableElement3,1.5)
    
    local relativeParameter = animatableElement:getLayoutParameter()
    local relativeParameterAlign = relativeParameter:getAlign()
    relativeParameter:setAlign(relativeParameterAlign == ccui.RelativeAlign.alignParentLeftCenterVertical and ccui.RelativeAlign.alignParentRightBottom or ccui.RelativeAlign.alignParentLeftCenterVertical)
    animatableElement:setOpacity(animatableElement:getOpacity()==255 and 100 or 255)
    
    local relativeParameter2 = animatableElement2:getLayoutParameter()
    local relativeParameterAlign2 = relativeParameter2:getAlign()
    relativeParameter2:setAlign(relativeParameterAlign2 == ccui.RelativeAlign.alignParentRightBottom and ccui.RelativeAlign.locationAboveCenter or ccui.RelativeAlign.alignParentRightBottom)
    relativeParameter2:setRelativeToWidgetName("animatableElement")
    
    local relativeParameter3 = animatableElement3:getLayoutParameter()
    local relativeParameterAlign3 = relativeParameter3:getAlign()
    relativeParameter3:setAlign(relativeParameterAlign3 == ccui.RelativeAlign.alignParentLeftBottom and ccui.RelativeAlign.locationLeftOfCenter or ccui.RelativeAlign.alignParentLeftBottom)
    relativeParameter3:setRelativeToWidgetName("animatableElement")

    local transitionGroup = lgk.TransitionSpawn:create({transition,transition2,transition3})
    transitionGroup:run()
    
end

function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        
    end
    
    return scene
end


return TestScene