local TestScene = class("TransitionGroupTestScene",function()
    return require("TestScene").create({
        description = "Layout transitions with multiple elements";
        contentXML = "TransitionGroupTestScene"
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
            relativeParameter:setAlign(ccui.RelativeAlign.alignParentLeftCenterVertical)
            widget:layoutParameterChanged()
        end
    end)

    scene.transition1:setFinalStateCallback(function(widget)
        local relativeParameter = widget:getLayoutParameter()
        local align = relativeParameter:getAlign()
        relativeParameter:setAlign(ccui.RelativeAlign.alignParentRightBottom)
        widget:layoutParameterChanged()
    end)

    local animatableElement2 = scene.elements["animatableElement2"]
    scene.transition2 = lgk.Transition:create(animatableElement2)

    scene.transition2:setInitialStateCallback(function(widget)
        local relativeParameter = widget:getLayoutParameter()
        local align = relativeParameter:getAlign()
        relativeParameter:setAlign(ccui.RelativeAlign.alignParentRightBottom)
        widget:layoutParameterChanged()
    end)

    scene.transition2:setFinalStateCallback(function(widget)
        local relativeParameter = widget:getLayoutParameter()
        local align = relativeParameter:getAlign()
        relativeParameter:setAlign(ccui.RelativeAlign.locationAboveCenter)
        relativeParameter:setRelativeToWidgetName("animatableElement")
        widget:layoutParameterChanged()
    end)


    local animatableElement3 = scene.elements["animatableElement3"]
    scene.transition3 = lgk.Transition:create(animatableElement3)

    scene.transition3:setInitialStateCallback(function(widget)
        local relativeParameter = widget:getLayoutParameter()
        local align = relativeParameter:getAlign()
        relativeParameter:setAlign(ccui.RelativeAlign.alignParentLeftBottom)
        widget:layoutParameterChanged()
    end)

    scene.transition3:setFinalStateCallback(function(widget)
        local relativeParameter = widget:getLayoutParameter()
        local align = relativeParameter:getAlign()
        relativeParameter:setAlign(ccui.RelativeAlign.locationLeftOfCenter)
        relativeParameter:setRelativeToWidgetName("animatableElement")
        widget:layoutParameterChanged()
    end)

    scene.transitionSequence = lgk.TransitionGroup:create({scene.transition1,scene.transition2,scene.transition3})

    scene.execute = function(self)

    end

    return scene
end


return TestScene