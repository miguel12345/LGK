return function(p_actionHandler,p_elements)
    local widget = ccui.Layout:create()
    local screenSize = cc.Director:getInstance():getWinSize()
    widget:setPosition(0,0)
    widget:setContentSize(screenSize)
    widget:setLayoutType(ccui.LayoutType.RELATIVE)
    widget:setSizeType(ccui.SizeType.percent)
    widget:setSizePercent({x=1.0;y=1.0})
    widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
    widget:setBackGroundColor({r = 0; g = 0; b = 120})
    p_elements['SceneRoot'] = widget
    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("SceneRoot")
        end
        
    local child = (function()
        local widget = ccui.Layout:create()
        widget:setCascadeOpacityEnabled(true)
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 1.0; height = 0.95})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.alignParentBottomCenterHorizontal
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 1.0; height = 1.0})
            local layoutParameter = nil
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.centerInParent
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
                widget:setLayoutParameter(layoutParameter)
            end
            p_elements['SceneContentRoot'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("SceneContentRoot")
        end
        
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Button:create('home.png')
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 50; height = 50})
            local layoutParameter = nil
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentTopLeft
            layoutParameter:setAlign(alignment)
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 10;right = 0;top = 10;bottom = 0;})
            if layoutParameter ~= nil then
                widget:setLayoutParameter(layoutParameter)
            end
            p_elements['homeButton'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("homeButton")
        end
        
            widget:ignoreContentAdaptWithSize(false)
            widget:setTouchEnabled(true)
            widget:addTouchEventListener(function(widget,touchType)
                if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                    if touchType == ccui.TouchEventType.ended then
                                    p_actionHandler['goHome'](p_actionHandler,widget)
                    end
                end
            end)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Button:create('arrow-left-b.png')
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 100; height = 100})
            local layoutParameter = nil
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentLeftBottom
            layoutParameter:setAlign(alignment)
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 0;right = 0;top = 10;bottom = 0;})
            if layoutParameter ~= nil then
                widget:setLayoutParameter(layoutParameter)
            end
            p_elements['leftButton'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("leftButton")
        end
        
            widget:ignoreContentAdaptWithSize(false)
            widget:setTouchEnabled(true)
            widget:addTouchEventListener(function(widget,touchType)
                if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                    if touchType == ccui.TouchEventType.ended then
                                    p_actionHandler['goToPreviousScene'](p_actionHandler,widget)
                    end
                end
            end)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Button:create('arrow-right-b.png')
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 100; height = 100})
            local layoutParameter = nil
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentRightBottom
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
                widget:setLayoutParameter(layoutParameter)
            end
            p_elements['rightButton'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("rightButton")
        end
        
            widget:ignoreContentAdaptWithSize(false)
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
        local child = (function()
            local widget = ccui.Button:create('execute-test-icon.png')
            widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
            widget:setSizeValues({width = 50; height = 50})
            local layoutParameter = nil
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            layoutParameter:setAlign(ccui.RelativeAlign.locationAboveCenter)
            layoutParameter:setRelativeToWidgetName('description')
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 0;right = 0;top = 0;bottom = 10;})
            if layoutParameter ~= nil then
                widget:setLayoutParameter(layoutParameter)
            end
            p_elements['executeButton'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("executeButton")
        end
        
            widget:ignoreContentAdaptWithSize(false)
            widget:setTouchEnabled(true)
            widget:addTouchEventListener(function(widget,touchType)
                if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                    if touchType == ccui.TouchEventType.ended then
                                    p_actionHandler['execute'](p_actionHandler,widget)
                    end
                end
            end)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget =  ccui.Text:create('Test Description here','fonts/Marker Felt.ttf',30)
            local layoutParameter = nil
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentBottomCenterHorizontal
            layoutParameter:setAlign(alignment)
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 0;right = 0;top = 0;bottom = 20;})
            if layoutParameter ~= nil then
                widget:setLayoutParameter(layoutParameter)
            end
            p_elements['description'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("description")
        end
        
            widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
            return widget
        end)()
        widget:addChild(child)
        return widget
    end)()
    widget:addChild(child)
    return widget
end