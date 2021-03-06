return function(p_actionHandler,p_elements)
    local transitions = {}
    local child = (function()
        local widget = p_elements['animatableElement']
        assert(widget~=nil,"Unable to find widget named animatableElement when inflating transition")
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
            widget:setName('animatableElement')
            p_elements['animatableElement'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElement")
        end
        
        end)
        return transition
    end)()
    transitions[#transitions+1] =child
    local child = (function()
        local widget = p_elements['animatableElement2']
        assert(widget~=nil,"Unable to find widget named animatableElement2 when inflating transition")
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
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            local layoutParameterMargin = layoutParameter:getMargin()
local marginTable = {left = 0;right = 0;top = 0;bottom = 100;}if (layoutParameterMargin.left ~= marginTable.left or 
layoutParameterMargin.right ~= marginTable.right or 
 layoutParameterMargin.bottom ~= marginTable.bottom or
layoutParameterMargin.top ~= marginTable.top) then
    layoutParameterChanged = true
    layoutParameter:setMargin(marginTable)
end
            if layoutParameterChanged then
                widget:layoutParameterChanged()
            end
            widget:setName('animatableElement2')
            p_elements['animatableElement2'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElement2")
        end
        
        end)
        return transition
    end)()
    transitions[#transitions+1] =child
    local child = (function()
        local widget = p_elements['animatableElement3']
        assert(widget~=nil,"Unable to find widget named animatableElement3 when inflating transition")
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
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            local layoutParameterMargin = layoutParameter:getMargin()
local marginTable = {left = 0;right = 100;top = 0;bottom = 0;}if (layoutParameterMargin.left ~= marginTable.left or 
layoutParameterMargin.right ~= marginTable.right or 
 layoutParameterMargin.bottom ~= marginTable.bottom or
layoutParameterMargin.top ~= marginTable.top) then
    layoutParameterChanged = true
    layoutParameter:setMargin(marginTable)
end
            if layoutParameterChanged then
                widget:layoutParameterChanged()
            end
            widget:setName('animatableElement3')
            p_elements['animatableElement3'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElement3")
        end
        
        end)
        return transition
    end)()
    transitions[#transitions+1] =child
    local transition = lgk.TransitionGroup:create(transitions)
    return transition
end