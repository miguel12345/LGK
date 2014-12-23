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
        local widget = ccexp.WebView:create()
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 0.6; height = 0.6})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['webview'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("webview")
        end
        
        widget:ignoreContentAdaptWithSize(false)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = ccui.Layout:create()
        widget:setCascadeOpacityEnabled(true)
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        layoutParameter:setAlign(ccui.RelativeAlign.locationAboveCenter)
        layoutParameter:setRelativeToWidgetName('webview')
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setWrapContent(true)
        widget:setLayoutType(ccui.LayoutType.VERTICAL)
        local child = (function()
            local widget = ccui.Button:create('')
            p_elements['changeURL'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("changeURL")
        end
        
            widget:setTitleText('Change URL to google')
            widget:setTitleFontSize(30)
            widget:setTouchEnabled(true)
            widget:addTouchEventListener(function(widget,touchType)
                if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                    if touchType == ccui.TouchEventType.ended then
                                    p_actionHandler['changeURLToGoogle'](p_actionHandler,widget)
                    end
                end
            end)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Button:create('')
            p_elements['changeURL'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("changeURL")
        end
        
            widget:setTitleText('Change URL to amazon')
            widget:setTitleFontSize(30)
            widget:setTouchEnabled(true)
            widget:addTouchEventListener(function(widget,touchType)
                if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                    if touchType == ccui.TouchEventType.ended then
                                    p_actionHandler['changeURLToAmazon'](p_actionHandler,widget)
                    end
                end
            end)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Button:create('')
            p_elements['loadHTML'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("loadHTML")
        end
        
            widget:setTitleText('Load Html')
            widget:setTitleFontSize(30)
            widget:setTouchEnabled(true)
            widget:addTouchEventListener(function(widget,touchType)
                if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                    if touchType == ccui.TouchEventType.ended then
                                    p_actionHandler['loadHTML'](p_actionHandler,widget)
                    end
                end
            end)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Button:create('')
            widget:setTitleText('Evaluate JS')
            widget:setTitleFontSize(30)
            widget:setTouchEnabled(true)
            widget:addTouchEventListener(function(widget,touchType)
                if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                    if touchType == ccui.TouchEventType.ended then
                                    p_actionHandler['evaluateJS'](p_actionHandler,widget)
                    end
                end
            end)
            return widget
        end)()
        widget:addChild(child)
        return widget
    end)()
    widget:addChild(child)
    return widget
end