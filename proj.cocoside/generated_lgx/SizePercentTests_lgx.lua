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
        widget:setBackGroundColor({r = 180; g = 0; b = 0; a = 255})
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.absolute)
        widget:setSizeValues({width = 1.0; height = 200})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.alignParentTopCenterHorizontal
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
        p_elements['fullScreenWidth'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("fullScreenWidth")
        end
        
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        local child = (function()
            local widget =  ccui.Text:create('size=1.0,200','fonts/Marker Felt.ttf',30)
            local layoutParameter = widget:getLayoutParameter()
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.centerInParent
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
            p_elements['description'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("description")
        end
        
            widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
            return widget
        end)()
        widget:addChild(child)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = ccui.Layout:create()
        local layoutParameter = widget:getLayoutParameter()
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 0; g = 0; b = 0; a = 255})
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.absolute)
        widget:setSizeValues({width = 1.0; height = 200})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.alignParentTopCenterHorizontal
        layoutParameter:setAlign(alignment)
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 0;top = 200;bottom = 0;})
        if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
        widget:setLayoutType(ccui.LayoutType.HORIZONTAL)
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 0; g = 180; b = 0; a = 255})
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 0.5; height = 1.0})
            if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
            p_elements['halfScreenWidth'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("halfScreenWidth")
        end
        
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            local child = (function()
                local widget =  ccui.Text:create('size=0.5,1.0','fonts/Marker Felt.ttf',30)
                local layoutParameter = widget:getLayoutParameter()
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
                p_elements['description'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("description")
        end
        
                widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
                return widget
            end)()
            widget:addChild(child)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 0; g = 0; b = 200; a = 255})
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 0.5; height = 1.0})
            if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            local child = (function()
                local widget =  ccui.Text:create('size=0.5,1.0','fonts/Marker Felt.ttf',30)
                local layoutParameter = widget:getLayoutParameter()
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
                p_elements['description'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("description")
        end
        
                widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
                return widget
            end)()
            widget:addChild(child)
            return widget
        end)()
        widget:addChild(child)
        return widget
    end)()
    widget:addChild(child)
    return widget
end