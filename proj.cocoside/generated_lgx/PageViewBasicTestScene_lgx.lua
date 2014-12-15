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
        local widget = ccui.PageView:create()
        local layoutParameter = widget:getLayoutParameter()
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 600; height = 400})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
        widget:setCustomScrollThreshold(30.0)
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 255; g = 0; b = 0; a = 255})
            if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 0; g = 255; b = 0; a = 255})
            if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 0; g = 255; b = 255; a = 255})
            if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
            return widget
        end)()
        widget:addChild(child)
        return widget
    end)()
    widget:addChild(child)
    return widget
end