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
        local widget =  ccui.Text:create('Scene 1','Helvetica',20)
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.absolute)
        widget:setSizeValues({width = 0.5; height = -1})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
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
    local child = (function()
        local widget = ccui.Button:create('')
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        layoutParameter:setAlign(ccui.RelativeAlign.locationBelowCenter)
        layoutParameter:setRelativeToWidgetName('text')
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setTitleText('Go to next scene')
        widget:setTitleFontSize(20)
        widget:setTouchEnabled(true)
        widget:addTouchEventListener(function(widget,touchType)
            if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                if touchType == ccui.TouchEventType.ended then
                            p_actionHandler['goToNextScene'](p_actionHandler,widget)
                end
            end
        end)
        return widget
    end)()
    widget:addChild(child)
    return widget
end