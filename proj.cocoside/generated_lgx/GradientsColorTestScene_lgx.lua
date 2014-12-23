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
        local widget = ccui.Layout:create()
        widget:setCascadeOpacityEnabled(true)
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['gradientsRoot'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("gradientsRoot")
        end
        
        widget:setWrapContent(true)
        widget:setLayoutType(ccui.LayoutType.HORIZONTAL)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.gradient)
            widget:setBackGroundColor({r = 4; g = 175; b = 255; a = 255},{r = 4; g = 232; b = 197; a = 255})
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 200; height = 200})
            p_elements['blueGradient'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("blueGradient")
        end
        
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            local child = (function()
                local widget =  ccui.Text:create('Horizontal','fonts/Marker Felt.ttf',15)
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
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
            widget:setCascadeOpacityEnabled(true)
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.gradient)
            widget:setBackGroundColor({r = 255; g = 0; b = 243; a = 255},{r = 106; g = 0; b = 232; a = 255})
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 200; height = 200})
            p_elements['pinkGradient'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("pinkGradient")
        end
        
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            local child = (function()
                local widget =  ccui.Text:create('Vertical','fonts/Marker Felt.ttf',15)
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
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