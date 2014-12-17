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
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setWrapContent(true)
        widget:setLayoutType(ccui.LayoutType.VERTICAL)
        local child = (function()
            local widget = ccui.Button:create('')
            local layoutParameter = widget:getLayoutParameter()
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.centerInParent
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
            p_elements['lockLandscape'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("lockLandscape")
        end
        
            widget:setTitleText('Lock orientation to landscape')
            widget:setTitleFontSize(70)
            local handlerFunction = function(sender,eventType)
                                        if eventType == ccui.TouchEventType.ended then
                                            p_actionHandler["lockLandscape"](p_actionHandler,widget,eventType)
                                        end
                                    end
                                    widget:addTouchEventListener(handlerFunction)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Button:create('')
            local layoutParameter = widget:getLayoutParameter()
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 0;right = 0;top = 20;bottom = 0;})
            if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
            p_elements['lockPortrait'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("lockPortrait")
        end
        
            widget:setTitleText('Lock orientation to portrait')
            widget:setTitleFontSize(70)
            local handlerFunction = function(sender,eventType)
                                        if eventType == ccui.TouchEventType.ended then
                                            p_actionHandler["lockPortrait"](p_actionHandler,widget,eventType)
                                        end
                                    end
                                    widget:addTouchEventListener(handlerFunction)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Button:create('')
            local layoutParameter = widget:getLayoutParameter()
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 0;right = 0;top = 20;bottom = 0;})
            if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
            p_elements['unlock'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("unlock")
        end
        
            widget:setTitleText('Unlock device orientation')
            widget:setTitleFontSize(70)
            local handlerFunction = function(sender,eventType)
                                        if eventType == ccui.TouchEventType.ended then
                                            p_actionHandler["unlockDeviceOrientation"](p_actionHandler,widget,eventType)
                                        end
                                    end
                                    widget:addTouchEventListener(handlerFunction)
            return widget
        end)()
        widget:addChild(child)
        return widget
    end)()
    widget:addChild(child)
    return widget
end