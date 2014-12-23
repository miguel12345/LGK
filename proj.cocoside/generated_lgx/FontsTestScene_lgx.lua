return function(p_actionHandler,p_elements)
    local widget = ccui.Layout:create()
    widget:setCascadeOpacityEnabled(true)
    widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
    widget:setSizeValues({width = 1.0; height = 1.0})
    p_elements['root'] = widget
    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("root")
        end
        
    widget:setLayoutType(ccui.LayoutType.RELATIVE)
    local child = (function()
        local widget =  ccui.Text:create('Shadowed','tests/res/fonts/Proxima Nova Light.ttf',85)
        widget:enableShadow({r = 255; g = 0; b = 255; a = 200},{width = -4; height= 2})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['center'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("center")
        end
        
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget =  ccui.Text:create('Multiline text with wrap','tests/res/fonts/Proxima Nova Light.ttf',40)
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 120; height = 250})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        layoutParameter:setAlign(ccui.RelativeAlign.locationBelowCenter)
        layoutParameter:setRelativeToWidgetName('center')
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['bottom'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("bottom")
        end
        
        widget:setAdaptLabelScaleWithContentSize(true)
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptFontSizeToFit(false)
        
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget =  ccui.Text:create('Should be scaled','tests/res/fonts/Proxima Nova Light.ttf',85)
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 200; height = 260})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        layoutParameter:setAlign(ccui.RelativeAlign.locationAboveCenter)
        layoutParameter:setRelativeToWidgetName('center')
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 0;top = 0;bottom = 10;})
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['top'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("top")
        end
        
        widget:setAdaptLabelScaleWithContentSize(true)
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptFontSizeToFit(false)
        
        return widget
    end)()
    widget:addChild(child)
    return widget
end