return function(p_actionHandler,p_elements)
    local widget = ccui.Layout:create()
    widget:setCascadeOpacityEnabled(true)
    widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
    widget:setBackGroundColor({r = 0; g = 0; b = 0; a = 255})
    widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
    widget:setSizeValues({width = 1.0; height = 0.2})
    p_elements['element'] = widget
    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("element")
        end
        
    widget:setLayoutType(ccui.LayoutType.RELATIVE)
    return widget
end