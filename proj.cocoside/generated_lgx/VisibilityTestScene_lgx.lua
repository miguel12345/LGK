return function(p_actionHandler,p_elements)
    local widget = ccui.Layout:create()
    local layoutParameter = widget:getLayoutParameter()
    widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
    widget:setSizeValues({width = 1.0; height = 1.0})
    if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
    widget:setLayoutType(ccui.LayoutType.RELATIVE)
    local child = (function()
        local widget = ccui.Layout:create()
        local layoutParameter = widget:getLayoutParameter()
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 600; height = 250})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.alignParentTopCenterHorizontal
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 600; height = 100})
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentTopCenterHorizontal
            layoutParameter:setAlign(alignment)
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 0;right = 0;top = 20;bottom = 0;})
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
                local layoutParameter = widget:getLayoutParameter()
                widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
                widget:setBackGroundColor({r = 255; g = 0; b = 0; a = 255})
                widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
                widget:setSizeValues({width = 200; height = 100})
                if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
                p_elements['red'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("red")
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
                widget:setSizeValues({width = 200; height = 100})
                if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
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
                local layoutParameter = widget:getLayoutParameter()
                widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
                widget:setBackGroundColor({r = 0; g = 0; b = 255; a = 255})
                widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
                widget:setSizeValues({width = 200; height = 100})
                if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
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
            local layoutParameter = widget:getLayoutParameter()
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentBottomCenterHorizontal
            layoutParameter:setAlign(alignment)
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 0;right = 0;top = 0;bottom = 50;})
            if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
            widget:setTitleText('collapse/show green area')
            widget:setTitleFontSize(20)
            widget:setTouchEnabled(true)
            widget:addTouchEventListener(function(widget,touchType)
                if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                    if touchType == ccui.TouchEventType.ended then
                                    p_actionHandler['showCollapseGreenArea'](p_actionHandler,widget)
                    end
                end
            end)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Button:create('')
            local layoutParameter = widget:getLayoutParameter()
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentBottomCenterHorizontal
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
            widget:setTitleText('hide/show green area')
            widget:setTitleFontSize(20)
            widget:setTouchEnabled(true)
            widget:addTouchEventListener(function(widget,touchType)
                if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                    if touchType == ccui.TouchEventType.ended then
                                    p_actionHandler['showHideGreenArea'](p_actionHandler,widget)
                    end
                end
            end)
            return widget
        end)()
        widget:addChild(child)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = ccui.Layout:create()
        local layoutParameter = widget:getLayoutParameter()
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 600; height = 250})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.alignParentTopCenterHorizontal
        layoutParameter:setAlign(alignment)
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 0;top = 300;bottom = 0;})
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        local child = (function()
            local widget = ccui.Layout:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 600; height = 100})
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentTopCenterHorizontal
            layoutParameter:setAlign(alignment)
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 0;right = 0;top = 20;bottom = 0;})
            if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
            p_elements['parent2'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("parent2")
        end
        
            widget:setLayoutType(ccui.LayoutType.HORIZONTAL)
            local child = (function()
                local widget = ccui.Layout:create()
                local layoutParameter = widget:getLayoutParameter()
                widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
                widget:setBackGroundColor({r = 255; g = 0; b = 0; a = 255})
                widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
                widget:setSizeValues({width = 200; height = 100})
                if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
                p_elements['red2'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("red2")
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
                widget:setSizeValues({width = 200; height = 100})
                widget:setVisibility(ccui.Visibility.collapsed)
                if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
                p_elements['green2'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("green2")
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
                widget:setSizeValues({width = 200; height = 100})
                if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
                p_elements['blue2'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("blue2")
        end
        
                return widget
            end)()
            widget:addChild(child)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget =  ccui.Text:create('Green starts collapsed','fonts/Marker Felt.ttf',15)
            local layoutParameter = widget:getLayoutParameter()
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentLeftCenterVertical
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
        local child = (function()
            local widget = ccui.Button:create('')
            local layoutParameter = widget:getLayoutParameter()
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentBottomCenterHorizontal
            layoutParameter:setAlign(alignment)
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 0;right = 0;top = 0;bottom = 50;})
            if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
            widget:setTitleText('collapse/show green area')
            widget:setTitleFontSize(20)
            widget:setTouchEnabled(true)
            widget:addTouchEventListener(function(widget,touchType)
                if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                    if touchType == ccui.TouchEventType.ended then
                                    p_actionHandler['showCollapseGreenArea2'](p_actionHandler,widget)
                    end
                end
            end)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Button:create('')
            local layoutParameter = widget:getLayoutParameter()
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentBottomCenterHorizontal
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
            widget:setTitleText('hide/show green area')
            widget:setTitleFontSize(20)
            widget:setTouchEnabled(true)
            widget:addTouchEventListener(function(widget,touchType)
                if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                    if touchType == ccui.TouchEventType.ended then
                                    p_actionHandler['showHideGreenArea2'](p_actionHandler,widget)
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