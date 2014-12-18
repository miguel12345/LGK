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
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 0.5; height = 0.5})
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
            local layoutParameter = widget:getLayoutParameter()
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.absolute)
            widget:setSizeValues({width = 0.5; height = -1})
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
            widget:setTouchEnabled(true)
            local textColorOld = nil
            widget:addTouchEventListener(function(widget,touchType)
                if(touchType == ccui.TouchEventType.began) then
                    textColorOld = widget:getTextColor()
                    local layoutParameter = widget:getLayoutParameter()
                    local layoutParameterChanged = false
                    if layoutParameterChanged then
            widget:layoutParameterChanged()
        end
                    widget:setTextColor({r = 255; g = 0; b = 0; a = 255})
                elseif(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                widget:setTextColor(textColorOld)
                end
            end)
            return widget
        end)()
        widget:addChild(child)
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        widget:setTouchEnabled(true)
        local backgroundColorOld = nil
        widget:addTouchEventListener(function(widget,touchType)
            if(touchType == ccui.TouchEventType.began) then
                backgroundColorOld = widget:getBackGroundColor()
                local layoutParameter = widget:getLayoutParameter()
                local layoutParameterChanged = false
                widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
                widget:setBackGroundColor({r = 0; g = 255; b = 0; a = 255})
                if layoutParameterChanged then
            widget:layoutParameterChanged()
        end
                widget:setLayoutType(ccui.LayoutType.RELATIVE)
            elseif(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
            widget:setBackGroundColor(backgroundColorOld)
            end
        end)
        return widget
    end)()
    widget:addChild(child)
    return widget
end