return function(p_actionHandler,p_elements)
    local transitions = {}
    local child = (function()
        local transitions = {}
        local child = (function()
            local widget = p_elements['center']
            assert(widget~=nil,"Unable to find widget named center when inflating transition")
            local transition = lgk.Transition:create(widget)
            transition:setDuration(1.5)
            transition:setFinalStateCallback(function(widget)
                local layoutParameter = widget:getLayoutParameter()
                widget:setOpacity(0)
                if widget:getLayoutParameter() ~= layoutParameter then
            widget:setLayoutParameter(layoutParameter)
        end
                widget:setName('center')
                p_elements['center'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("center")
        end
        
            end)
            return transition
        end)()
        transitions[#transitions+1] =child
        local child = (function()
            local widget = p_elements['bottom']
            assert(widget~=nil,"Unable to find widget named bottom when inflating transition")
            local transition = lgk.Transition:create(widget)
            transition:setDuration(1.5)
            transition:setFinalStateCallback(function(widget)
                local layoutParameter = widget:getLayoutParameter()
                widget:setOpacity(0)
                if widget:getLayoutParameter() ~= layoutParameter then
            widget:setLayoutParameter(layoutParameter)
        end
                widget:setName('bottom')
                p_elements['bottom'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("bottom")
        end
        
            end)
            return transition
        end)()
        transitions[#transitions+1] =child
        local transition = lgk.TransitionGroup:create(transitions)
        return transition
    end)()
    transitions[#transitions+1] =child
    local child = (function()
        local transitions = {}
        local child = (function()
            local widget = p_elements['center']
            assert(widget~=nil,"Unable to find widget named center when inflating transition")
            local transition = lgk.Transition:create(widget)
            transition:setDuration(0.8)
            transition:setFinalStateCallback(function(widget)
                local layoutParameter = widget:getLayoutParameter()
                widget:setOpacity(255)
                if widget:getLayoutParameter() ~= layoutParameter then
            widget:setLayoutParameter(layoutParameter)
        end
                widget:setName('center')
                p_elements['center'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("center")
        end
        
            end)
            return transition
        end)()
        transitions[#transitions+1] =child
        local child = (function()
            local widget = p_elements['bottom']
            assert(widget~=nil,"Unable to find widget named bottom when inflating transition")
            local transition = lgk.Transition:create(widget)
            transition:setDuration(0.8)
            transition:setFinalStateCallback(function(widget)
                local layoutParameter = widget:getLayoutParameter()
                widget:setOpacity(255)
                if widget:getLayoutParameter() ~= layoutParameter then
            widget:setLayoutParameter(layoutParameter)
        end
                widget:setName('bottom')
                p_elements['bottom'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("bottom")
        end
        
            end)
            return transition
        end)()
        transitions[#transitions+1] =child
        local transition = lgk.TransitionGroup:create(transitions)
        return transition
    end)()
    transitions[#transitions+1] =child
    local transition = lgk.TransitionSequence:create(transitions)
    return transition
end