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
        p_elements['element'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("element")
        end
        
        local child = (function()
            local widget =  ccui.Text:create('Text Here','Helvetica',20)
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.absolute)
            widget:setSizeValues({width = 0.5; height = -1})
            local layoutParameter = nil
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentBottomCenterHorizontal
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
                widget:setLayoutParameter(layoutParameter)
            end
            p_elements['text'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("text")
        end
        
            widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)  
        widget:setAdaptFontSizeToFit(true)
        
            widget:setTextColor({r = 0; g = 255; b = 0; a = 255})
            local textColorOld = nil
            widget:setTouchEnabled(true)
            local _alreadyTouching = false
            widget:addTouchEventListener(function(widget,touchType)
                if(touchType == ccui.TouchEventType.began) then
                    if _alreadyTouching then return else _alreadyTouching = true end
                                textColorOld = widget:getTextColor()
                                widget:setTextColor({r = 255; g = 0; b = 0; a = 255})
                elseif(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                    if not _alreadyTouching then return else _alreadyTouching = false end
                                widget:setTextColor(textColorOld)
                end
            end)
            return widget
        end)()
        widget:addChild(child)
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
                        widget:setBackGroundColor(backgroundColorOld)
            end
        end)
        return widget
    end)()
    widget:addChild(child)
    return widget
end