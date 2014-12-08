local TestScene = class("TransitionSingleTestScene",function()
    return require("TestScene").create({
        description = "Widget Transition";
        contentXML = "TransitionSingleTestScene"
    })
end)

function TestScene:animate()
    
    local animatableElement = self.elements["animatableElement"]
    local transition = self.transition or lgk.Transition:create(animatableElement)

    if not self.transition then
        transition:setInitialStateCallback(function(widget)
            local relativeParameter = widget:getLayoutParameter()
            local align = relativeParameter:getAlign()
            if align ~= ccui.RelativeAlign.alignParentTopLeft then
                relativeParameter:setAlign(ccui.RelativeAlign.alignParentTopLeft)
                widget:layoutParameterChanged()
            end
            widget:setOpacity(255)
        end)
        
        transition:setFinalStateCallback(function(widget)
            local relativeParameter = widget:getLayoutParameter()
            local align = relativeParameter:getAlign()
            if align ~= ccui.RelativeAlign.alignParentRightBottom then
                relativeParameter:setAlign(ccui.RelativeAlign.alignParentRightBottom)
                widget:layoutParameterChanged()
            end
            
            widget:setOpacity(120)
        end)
    end
    
   self.transition = transition
   
    if transition:isDone() or transition:isReversed() then
    	transition:reverse()
    end
    
    transition:run()
end

function TestScene.create()
    local scene = TestScene.new()
    
    scene.execute = function(self)
        
    end
    
    return scene
end


return TestScene