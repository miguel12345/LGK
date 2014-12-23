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
        local widget =  ccui.Text:create('This text should not jump when changed','Proxima Nova Light.ttf',35)
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 200; height = 0})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['text1'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("text1")
        end
        
        widget:setAdaptLabelScaleWithContentSize(true)
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptFontSizeToFit(false)
        
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget =  ccui.Text:create('This text should not jump when changed','Proxima Nova Light.ttf',35)
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 200; height = 200})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.alignParentTopCenterHorizontal
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['text2'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("text2")
        end
        
        widget:setAdaptLabelScaleWithContentSize(true)
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptFontSizeToFit(false)
        
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget =  ccui.Text:create('This text should not jump when changed','Proxima Nova Light.ttf',35)
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 200; height = 0})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.alignParentRightCenterVertical
        layoutParameter:setAlign(alignment)
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 10;top = 0;bottom = 0;})
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['text3'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("text3")
        end
        
        widget:setAdaptLabelScaleWithContentSize(true)
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptFontSizeToFit(false)
        
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget =  ccui.Text:create('This text should not jump when changed','Proxima Nova Light.ttf',35)
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.absolute)
        widget:setSizeValues({width = 1.0; height = 0})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.alignParentLeftBottom
        layoutParameter:setAlign(alignment)
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 20;right = 0;top = 0;bottom = 180;})
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['text4'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("text4")
        end
        
        widget:setAdaptLabelScaleWithContentSize(true)
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptFontSizeToFit(false)
        
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget =  ccui.Text:create('This text should not jump when changed','Proxima Nova Light.ttf',35)
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        layoutParameter:setAlign(ccui.RelativeAlign.locationAboveCenter)
        layoutParameter:setRelativeToWidgetName('text1')
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 0;top = 0;bottom = 10;})
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['text5'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("text5")
        end
        
        widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
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
        layoutParameter:setMargin({left = 0;right = 0;top = 0;bottom = 90;})
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setTitleText('Click here to reload scene')
        widget:setTitleFontSize(40)
        widget:setTouchEnabled(true)
        widget:addTouchEventListener(function(widget,touchType)
            if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                if touchType == ccui.TouchEventType.ended then
                            p_actionHandler['reloadScene'](p_actionHandler,widget)
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
        layoutParameter:setMargin({left = 0;right = 0;top = 0;bottom = 55;})
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setTitleText('Click here to change text')
        widget:setTitleFontSize(40)
        widget:setTouchEnabled(true)
        widget:addTouchEventListener(function(widget,touchType)
            if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                if touchType == ccui.TouchEventType.ended then
                            p_actionHandler['changeText'](p_actionHandler,widget)
                end
            end
        end)
        return widget
    end)()
    widget:addChild(child)
    return widget
end