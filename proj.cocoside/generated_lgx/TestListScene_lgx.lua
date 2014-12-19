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
        
        widget:setLayoutType(ccui.LayoutType.VERTICAL)
        local child = (function()
            local widget = ccui.ListView:create()
            local layoutParameter = widget:getLayoutParameter()
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 1.0; height = 1.0})
            layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
            layoutParameter:setMargin({left = 0;right = 0;top = 20;bottom = 0;})
            if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
            p_elements['elements'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("elements")
        end
        
            widget:setDirection(ccui.ListViewDirection.vertical)
            return widget
        end)()
        widget:addChild(child)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = ccui.Button:create('home.png')
        local layoutParameter = widget:getLayoutParameter()
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 50; height = 50})
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
        local widget = ccui.Button:create('execute-test-icon.png')
        local layoutParameter = widget:getLayoutParameter()
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 50; height = 50})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.alignParentTopRight
        layoutParameter:setAlign(alignment)
        layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
        layoutParameter:setMargin({left = 0;right = 10;top = 10;bottom = 0;})
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['executeTestsButton'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("executeTestsButton")
        end
        
        widget:ignoreContentAdaptWithSize(false)
        widget:setTouchEnabled(true)
        widget:addTouchEventListener(function(widget,touchType)
            if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                if touchType == ccui.TouchEventType.ended then
                            p_actionHandler['executeAllTestsInElement'](p_actionHandler,widget)
                end
            end
        end)
        return widget
    end)()
    widget:addChild(child)
    return widget
end