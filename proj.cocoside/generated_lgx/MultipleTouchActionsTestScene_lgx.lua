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
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 255; g = 0; b = 0; a = 255})
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 0.5; height = 0.5})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setPropagateTouchEventsToChildren(true)
        p_elements['touchElement'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("touchElement")
        end
        
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        local backgroundColorOld = nil
        widget:setTouchEnabled(true)
        local _alreadyTouching = false
        widget:addTouchEventListener(function(widget,touchType)
            if(touchType == ccui.TouchEventType.began) then
                if _alreadyTouching then return else _alreadyTouching = true end
                        backgroundColorOld = widget:getBackGroundColor()
                        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
                        widget:setBackGroundColor({r = 0; g = 255; b = 0; a = 255})
                        widget:setLayoutType(ccui.LayoutType.RELATIVE)
            elseif(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                if not _alreadyTouching then return else _alreadyTouching = false end
                if touchType == ccui.TouchEventType.ended then
                            p_actionHandler['showHideElement'](p_actionHandler,widget)
                end
                        widget:setBackGroundColor(backgroundColorOld)
            end
        end)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = ccui.Layout:create()
        widget:setCascadeOpacityEnabled(true)
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 0; g = 0; b = 255; a = 255})
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 100; height = 100})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        layoutParameter:setAlign(ccui.RelativeAlign.locationBelowCenter)
        layoutParameter:setRelativeToWidgetName('touchElement')
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 0;top = 10;bottom = 0;})
        widget:setOpacity(0)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['showHideElement'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("showHideElement")
        end
        
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        return widget
    end)()
    widget:addChild(child)
    return widget
end