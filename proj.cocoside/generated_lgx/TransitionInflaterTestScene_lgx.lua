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
        local widget = ccui.Button:create('')
        local layoutParameter = widget:getLayoutParameter()
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        layoutParameter:setAlign(ccui.RelativeAlign.locationAboveCenter)
        layoutParameter:setRelativeToWidgetName('area')
        if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
        widget:setTitleText('Animate')
        widget:setTitleFontSize(40)
        local handlerFunction = function(sender,eventType)
                                        if eventType == ccui.TouchEventType.ended then
                                            p_actionHandler["animate"](p_actionHandler,widget,eventType)
                                        end
                                    end
                                    widget:addTouchEventListener(handlerFunction)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = ccui.Layout:create()
        local layoutParameter = widget:getLayoutParameter()
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 0; g = 0; b = 0})
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 0.5; height = 0.5})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
        p_elements['area'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("area")
        end
        
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 255; g = 0; b = 0; a = 255})
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 100; height = 100})
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentTopLeft
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
            p_elements['animatableElementTL'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementTL")
        end
        
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 0; g = 255; b = 0; a = 255})
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 100; height = 100})
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentTopCenterHorizontal
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
            p_elements['animatableElementTC'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementTC")
        end
        
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 0; g = 0; b = 255; a = 255})
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 100; height = 100})
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentTopRight
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
            p_elements['animatableElementTR'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementTR")
        end
        
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 255; g = 255; b = 255; a = 255})
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 100; height = 100})
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentLeftBottom
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
            p_elements['animatableElementBL'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementBL")
        end
        
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 150; g = 150; b = 150; a = 255})
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 100; height = 100})
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentBottomCenterHorizontal
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
            p_elements['animatableElementBC'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementBC")
        end
        
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 70; g = 70; b = 70; a = 255})
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 100; height = 100})
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentRightBottom
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
            p_elements['animatableElementBR'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("animatableElementBR")
        end
        
            return widget
        end)()
        widget:addChild(child)
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        return widget
    end)()
    widget:addChild(child)
    return widget
end