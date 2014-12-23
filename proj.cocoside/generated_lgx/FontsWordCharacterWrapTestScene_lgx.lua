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
        
    widget:setLayoutType(ccui.LayoutType.VERTICAL)
    local child = (function()
        local widget =  ccui.Text:create('You should see this text with word wrapping since it is the default','tests/res/fonts/Proxima Nova Light.ttf',30)
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 200; height = 0})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 0;top = 10;bottom = 0;})
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setGravity(ccui.LinearGravity.centerHorizontal)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['wordWrap'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("wordWrap")
        end
        
        widget:setAdaptLabelScaleWithContentSize(true)
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptFontSizeToFit(false)
        
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget =  ccui.Text:create('You should see this text with word wrapping','tests/res/fonts/Proxima Nova Light.ttf',30)
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 200; height = 0})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 0;top = 20;bottom = 0;})
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setGravity(ccui.LinearGravity.centerHorizontal)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['wordWrap'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("wordWrap")
        end
        
        widget:setAdaptLabelScaleWithContentSize(true)
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptFontSizeToFit(false)
        
        widget:setLineBreakWithoutSpace(false)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget =  ccui.Text:create('You should see this text with character wrapping','tests/res/fonts/Proxima Nova Light.ttf',30)
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 200; height = 0})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 0;top = 20;bottom = 0;})
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setGravity(ccui.LinearGravity.centerHorizontal)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['wordWrap'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("wordWrap")
        end
        
        widget:setAdaptLabelScaleWithContentSize(true)
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptFontSizeToFit(false)
        
        widget:setLineBreakWithoutSpace(true)
        return widget
    end)()
    widget:addChild(child)
    return widget
end