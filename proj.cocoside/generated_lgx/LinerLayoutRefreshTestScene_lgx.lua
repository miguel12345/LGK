return function(p_actionHandler,p_elements)
    local widget = ccui.Layout:create()
    widget:setCascadeOpacityEnabled(true)
    widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
    widget:setSizeValues({width = 1.0; height = 1.0})
    widget:setLayoutType(ccui.LayoutType.RELATIVE)
    local child = (function()
        local widget = ccui.Layout:create()
        widget:setCascadeOpacityEnabled(true)
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 255; g = 255; b = 255; a = 255})
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 800; height = 200})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['parent'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("parent")
        end
        
        widget:setLayoutType(ccui.LayoutType.HORIZONTAL)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 255; g = 0; b = 0; a = 255})
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 200; height = 200})
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 0; g = 255; b = 0; a = 255})
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 200; height = 200})
            p_elements['green'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("green")
        end
        
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
            widget:setBackGroundColor({r = 0; g = 0; b = 255; a = 255})
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 200; height = 200})
            p_elements['blue'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("blue")
        end
        
            return widget
        end)()
        widget:addChild(child)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = ccui.Button:create('')
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.alignParentBottomCenterHorizontal
        layoutParameter:setAlign(alignment)
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 0;top = 0;bottom = 150;})
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setTitleText('Expand Green Area')
        widget:setTitleFontSize(30)
        widget:setTouchEnabled(true)
        widget:addTouchEventListener(function(widget,touchType)
            if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                if touchType == ccui.TouchEventType.ended then
                            p_actionHandler['expandGreenArea'](p_actionHandler,widget)
                end
            end
        end)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = ccui.Button:create('')
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.alignParentBottomCenterHorizontal
        layoutParameter:setAlign(alignment)
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 0;top = 0;bottom = 100;})
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setTitleText('Shrink Green Area')
        widget:setTitleFontSize(30)
        widget:setTouchEnabled(true)
        widget:addTouchEventListener(function(widget,touchType)
            if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                if touchType == ccui.TouchEventType.ended then
                            p_actionHandler['shrinkGreenArea'](p_actionHandler,widget)
                end
            end
        end)
        return widget
    end)()
    widget:addChild(child)
    return widget
end