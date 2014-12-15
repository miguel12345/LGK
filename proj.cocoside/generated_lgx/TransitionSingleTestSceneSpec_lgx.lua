return function(p_actionHandler,p_elements)
    local widget = p_elements['animatableElement']
    assert(widget~=nil,"Unable to find widget named animatableElement when inflating transition")
    local transition = lgk.Transition:create(widget)
    transition:setDuration(0.5)
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
end