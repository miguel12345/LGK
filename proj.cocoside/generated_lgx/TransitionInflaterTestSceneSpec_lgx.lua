return function(p_actionHandler,p_elements)
    local transitions = {}
    local child = (function()
        local transitions = {}
        local child = (function()
            local transitions = {}
            local child = (function()
                local widget = p_elements['animatableElementTL']
                assert(widget~=nil,"Unable to find widget named animatableElementTL when inflating transition")
                local transition = lgk.Transition:create(widget)
                transition:setDuration(0.3)
                transition:setFinalStateCallback(function(widget)
                    local layoutParameter = widget:getLayoutParameter()
                    local layoutParameterChanged = false
                    layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                    local alignment = ccui.RelativeAlign.alignParentLeftBottom
                    if layoutParameter:getAlign() ~=alignment then
    layoutParameterChanged = true
    layoutParameter:setAlign(alignment)
end
                    if layoutParameterChanged then
    widget:layoutParameterChanged()
end
                    widget:setName('animatableElementTL')
                    p_elements['animatableElementTL'] = widget
                    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementTL")
        end
        
                end)
                return transition
            end)()
            transitions[#transitions+1] =child
            local child = (function()
                local widget = p_elements['animatableElementTC']
                assert(widget~=nil,"Unable to find widget named animatableElementTC when inflating transition")
                local transition = lgk.Transition:create(widget)
                transition:setDuration(0.3)
                transition:setFinalStateCallback(function(widget)
                    local layoutParameter = widget:getLayoutParameter()
                    local layoutParameterChanged = false
                    layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                    local alignment = ccui.RelativeAlign.alignParentBottomCenterHorizontal
                    if layoutParameter:getAlign() ~=alignment then
    layoutParameterChanged = true
    layoutParameter:setAlign(alignment)
end
                    if layoutParameterChanged then
    widget:layoutParameterChanged()
end
                    widget:setName('animatableElementTC')
                    p_elements['animatableElementTC'] = widget
                    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementTC")
        end
        
                end)
                return transition
            end)()
            transitions[#transitions+1] =child
            local child = (function()
                local widget = p_elements['animatableElementTR']
                assert(widget~=nil,"Unable to find widget named animatableElementTR when inflating transition")
                local transition = lgk.Transition:create(widget)
                transition:setDuration(0.3)
                transition:setFinalStateCallback(function(widget)
                    local layoutParameter = widget:getLayoutParameter()
                    local layoutParameterChanged = false
                    layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                    local alignment = ccui.RelativeAlign.alignParentRightBottom
                    if layoutParameter:getAlign() ~=alignment then
    layoutParameterChanged = true
    layoutParameter:setAlign(alignment)
end
                    if layoutParameterChanged then
    widget:layoutParameterChanged()
end
                    widget:setName('animatableElementTR')
                    p_elements['animatableElementTR'] = widget
                    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementTR")
        end
        
                end)
                return transition
            end)()
            transitions[#transitions+1] =child
            local transition = lgk.TransitionSequence:create(transitions)
            return transition
        end)()
        transitions[#transitions+1] =child
        local child = (function()
            local transitions = {}
            local child = (function()
                local widget = p_elements['animatableElementBL']
                assert(widget~=nil,"Unable to find widget named animatableElementBL when inflating transition")
                local transition = lgk.Transition:create(widget)
                transition:setDuration(0.3)
                transition:setFinalStateCallback(function(widget)
                    local layoutParameter = widget:getLayoutParameter()
                    local layoutParameterChanged = false
                    layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                    local alignment = ccui.RelativeAlign.alignParentTopLeft
                    if layoutParameter:getAlign() ~=alignment then
    layoutParameterChanged = true
    layoutParameter:setAlign(alignment)
end
                    if layoutParameterChanged then
    widget:layoutParameterChanged()
end
                    widget:setName('animatableElementBL')
                    p_elements['animatableElementBL'] = widget
                    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementBL")
        end
        
                end)
                return transition
            end)()
            transitions[#transitions+1] =child
            local child = (function()
                local widget = p_elements['animatableElementBC']
                assert(widget~=nil,"Unable to find widget named animatableElementBC when inflating transition")
                local transition = lgk.Transition:create(widget)
                transition:setDuration(0.3)
                transition:setFinalStateCallback(function(widget)
                    local layoutParameter = widget:getLayoutParameter()
                    local layoutParameterChanged = false
                    layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                    local alignment = ccui.RelativeAlign.alignParentTopCenterHorizontal
                    if layoutParameter:getAlign() ~=alignment then
    layoutParameterChanged = true
    layoutParameter:setAlign(alignment)
end
                    if layoutParameterChanged then
    widget:layoutParameterChanged()
end
                    widget:setName('animatableElementBC')
                    p_elements['animatableElementBC'] = widget
                    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementBC")
        end
        
                end)
                return transition
            end)()
            transitions[#transitions+1] =child
            local child = (function()
                local widget = p_elements['animatableElementBR']
                assert(widget~=nil,"Unable to find widget named animatableElementBR when inflating transition")
                local transition = lgk.Transition:create(widget)
                transition:setDuration(0.3)
                transition:setFinalStateCallback(function(widget)
                    local layoutParameter = widget:getLayoutParameter()
                    local layoutParameterChanged = false
                    layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                    local alignment = ccui.RelativeAlign.alignParentTopRight
                    if layoutParameter:getAlign() ~=alignment then
    layoutParameterChanged = true
    layoutParameter:setAlign(alignment)
end
                    if layoutParameterChanged then
    widget:layoutParameterChanged()
end
                    widget:setName('animatableElementBR')
                    p_elements['animatableElementBR'] = widget
                    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementBR")
        end
        
                end)
                return transition
            end)()
            transitions[#transitions+1] =child
            local transition = lgk.TransitionSequence:create(transitions)
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
            local widget = p_elements['animatableElementTL']
            assert(widget~=nil,"Unable to find widget named animatableElementTL when inflating transition")
            local transition = lgk.Transition:create(widget)
            transition:setDuration(0.3)
            transition:setFinalStateCallback(function(widget)
                local layoutParameter = widget:getLayoutParameter()
                local layoutParameterChanged = false
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.alignParentRightBottom
                if layoutParameter:getAlign() ~=alignment then
    layoutParameterChanged = true
    layoutParameter:setAlign(alignment)
end
                if layoutParameterChanged then
    widget:layoutParameterChanged()
end
                widget:setName('animatableElementTL')
                p_elements['animatableElementTL'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementTL")
        end
        
            end)
            return transition
        end)()
        transitions[#transitions+1] =child
        local child = (function()
            local widget = p_elements['animatableElementTR']
            assert(widget~=nil,"Unable to find widget named animatableElementTR when inflating transition")
            local transition = lgk.Transition:create(widget)
            transition:setDuration(0.4)
            transition:setFinalStateCallback(function(widget)
                local layoutParameter = widget:getLayoutParameter()
                local layoutParameterChanged = false
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.alignParentLeftBottom
                if layoutParameter:getAlign() ~=alignment then
    layoutParameterChanged = true
    layoutParameter:setAlign(alignment)
end
                if layoutParameterChanged then
    widget:layoutParameterChanged()
end
                widget:setName('animatableElementTR')
                p_elements['animatableElementTR'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementTR")
        end
        
            end)
            transition:setId('cenas3')
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
            local widget = p_elements['animatableElementBL']
            assert(widget~=nil,"Unable to find widget named animatableElementBL when inflating transition")
            local transition = lgk.Transition:create(widget)
            transition:setDuration(0.3)
            transition:setFinalStateCallback(function(widget)
                local layoutParameter = widget:getLayoutParameter()
                local layoutParameterChanged = false
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.alignParentTopRight
                if layoutParameter:getAlign() ~=alignment then
    layoutParameterChanged = true
    layoutParameter:setAlign(alignment)
end
                if layoutParameterChanged then
    widget:layoutParameterChanged()
end
                widget:setName('animatableElementBL')
                p_elements['animatableElementBL'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementBL")
        end
        
            end)
            transition:setId('cenas')
            return transition
        end)()
        transitions[#transitions+1] =child
        local child = (function()
            local widget = p_elements['animatableElementBR']
            assert(widget~=nil,"Unable to find widget named animatableElementBR when inflating transition")
            local transition = lgk.Transition:create(widget)
            transition:setDuration(0.3)
            transition:setFinalStateCallback(function(widget)
                local layoutParameter = widget:getLayoutParameter()
                local layoutParameterChanged = false
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.alignParentTopLeft
                if layoutParameter:getAlign() ~=alignment then
    layoutParameterChanged = true
    layoutParameter:setAlign(alignment)
end
                if layoutParameterChanged then
    widget:layoutParameterChanged()
end
                widget:setName('animatableElementBR')
                p_elements['animatableElementBR'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementBR")
        end
        
            end)
            return transition
        end)()
        transitions[#transitions+1] =child
        local transition = lgk.TransitionGroup:create(transitions)
        transition:setId('cenas2')
        return transition
    end)()
    transitions[#transitions+1] =child
    local transition = lgk.TransitionSequence:create(transitions)
    return transition
end