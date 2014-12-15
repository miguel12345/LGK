return function(p_actionHandler,p_elements)
    local widget = ccui.Layout:create()
    local layoutParameter = widget:getLayoutParameter()
    widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
    widget:setBackGroundColor({r = 255; g = 0; b = 255})
    widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
    widget:setSizeValues({width = 1.0; height = 0.25})
    if widget:getLayoutParameter() ~= layoutParameter then
            widget:setLayoutParameter(layoutParameter)
        end
    p_elements['center'] = widget
    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("center")
        end
        
    widget:setLayoutType(ccui.LayoutType.RELATIVE)
    return widget
end