return function(p_actionHandler,p_elements)
    local widget = ccui.Layout:create()
    local layoutParameter = widget:getLayoutParameter()
    widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
    widget:setSizeValues({width = 1.0; height = 1.0})
    if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
    widget:setLayoutType(ccui.LayoutType.RELATIVE)
    local child = (function()
        local widget = ccui.Layout:create()
        local layoutParameter = widget:getLayoutParameter()
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 0; g = 0; b = 0; a = 255})
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 0.5; height = 0.5})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 255; g = 0; b = 0; a = 255})
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 0.3; height = 0.3})
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 10;right = 0;top = 10;bottom = 0;})
            widget:setSizePercentSourceDimension(ccui.Widget.SizePercentSourceDimension.width)
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
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 0.3; height = 0.3})
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 10;right = 0;top = 10;bottom = 0;})
            widget:setSizePercentSourceDimension(ccui.Widget.SizePercentSourceDimension.width)
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
            widget:setBackGroundColor({r = 0; g = 0; b = 255; a = 255})
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 0.3; height = 0.3})
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 10;right = 0;top = 10;bottom = 0;})
            widget:setSizePercentSourceDimension(ccui.Widget.SizePercentSourceDimension.width)
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
            widget:setBackGroundColor({r = 255; g = 255; b = 255; a = 255})
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 0.3; height = 0.3})
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 10;right = 0;top = 10;bottom = 0;})
            widget:setSizePercentSourceDimension(ccui.Widget.SizePercentSourceDimension.width)
            if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
            return widget
        end)()
        widget:addChild(child)
        widget:setLayoutType(ccui.LayoutType.GRID)
        return widget
    end)()
    widget:addChild(child)
    return widget
end