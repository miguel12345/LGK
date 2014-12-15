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
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 200; height = 300})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['fitByWidthArea'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("fitByWidthArea")
        end
        
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget =  ccui.Text:create('Width','Proxima Nova Light.ttf',20)
        widget:enableShadow({r = 255; g = 255; b = 255; a = 60},{width = -4; height= 2})
        local layoutParameter = widget:getLayoutParameter()
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 200; height = 300})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['fitByWidth'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("fitByWidth")
        end
        
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)  
        widget:setAdaptFontSizeToFit(true)
        
        widget:setDebugDraw(true)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = ccui.Layout:create()
        local layoutParameter = widget:getLayoutParameter()
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 0; g = 255; b = 0; a = 255})
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 350; height = 40})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.alignParentTopCenterHorizontal
        layoutParameter:setAlign(alignment)
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 0;top = 10;bottom = 0;})
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['fitByHeightArea'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("fitByHeightArea")
        end
        
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget =  ccui.Text:create('Height','fonts/Proxima Nova Light.ttf',20)
        widget:enableShadow({r = 255; g = 255; b = 255; a = 60},{width = -4; height= 2})
        local layoutParameter = widget:getLayoutParameter()
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 350; height = 40})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.alignParentTopCenterHorizontal
        layoutParameter:setAlign(alignment)
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 0;top = 10;bottom = 0;})
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['fitByHeight'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("fitByHeight")
        end
        
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)  
        widget:setAdaptFontSizeToFit(true)
        
        widget:setDebugDraw(true)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget =  ccui.Text:create('Unspecified height','Proxima Nova Light.ttf',20)
        local layoutParameter = widget:getLayoutParameter()
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.absolute)
        widget:setSizeValues({width = .3; height = -1})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        layoutParameter:setAlign(ccui.RelativeAlign.locationAboveCenter)
        layoutParameter:setRelativeToWidgetName('fitByWidthArea')
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['unspecifiedHeight'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("unspecifiedHeight")
        end
        
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)  
        widget:setAdaptFontSizeToFit(true)
        
        widget:setDebugDraw(true)
        return widget
    end)()
    widget:addChild(child)
    return widget
end