return function(p_actionHandler,p_elements)
    local widget = ccui.Layout:create()
    local layoutParameter = widget:getLayoutParameter()
    widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
    widget:setSizeValues({width = 1.0; height = 1.0})
    if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
    p_elements['root'] = widget
    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("root")
        end
        
    widget:setLayoutType(ccui.LayoutType.RELATIVE)
    local child = (function()
        local widget = ccui.Layout:create()
        local layoutParameter = widget:getLayoutParameter()
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 255; g = 0; b = 0; a = 255})
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 0.5; height = 0.5})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setTouchEnabled(true)
        local previousBackgroundColor = nil
        widget:addTouchEventListener(function(widget,touchType)
            if(touchType == ccui.TouchEventType.began) then
                previousBackgroundColor = widget:getBackGroundColor()
                widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
                widget:setBackGroundColor({r = 0; g = 255; b = 0; a = 255})
            elseif((touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) and  previousBackgroundColor~=nil) then widget:setBackGroundColor(previousBackgroundColor) end
        end)
        p_elements['element'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("element")
        end
        
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        return widget
    end)()
    widget:addChild(child)
    return widget
end