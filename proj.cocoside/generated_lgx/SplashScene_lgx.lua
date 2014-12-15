return function(p_actionHandler,p_elements)
    local widget = ccui.Layout:create()
    local screenSize = cc.Director:getInstance():getWinSize()
    widget:setPosition(0,0)
    widget:setContentSize(screenSize)
    widget:setLayoutType(ccui.LayoutType.VERTICAL)
    widget:setSizeType(ccui.SizeType.percent)
    widget:setSizePercent({x=1.0;y=1.0})
    widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
    widget:setBackGroundColor({r = 0; g = 0; b = 120})
    p_elements['root'] = widget
    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("root")
        end
        
    local child = (function()
        local widget = ccui.Layout:create()
        local layoutParameter = widget:getLayoutParameter()
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 255; g = 0; b = 255})
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 1.0; height = 0.25})
        if widget:getLayoutParameter() ~= layoutParameter then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['center'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("center")
        end
        
        local child = (function()
            local widget = ccui.Button:create()
            local layoutParameter = widget:getLayoutParameter()
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.centerInParent
            layoutParameter:setAlign(alignment)
            if widget:getLayoutParameter() ~= layoutParameter then
            widget:setLayoutParameter(layoutParameter)
        end
            widget:setTitleText('click here 3')
            widget:setTitleFontSize(20)
            local handlerFunction = function(sender,eventType)
                                        if eventType == ccui.TouchEventType.ended then
                                            p_actionHandler["clickedButton"](p_actionHandler,widget,eventType)
                                        end
                                    end
                                    widget:addTouchEventListener(handlerFunction)
            return widget
        end)()
        widget:addChild(child)
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = ccui.Layout:create()
        local layoutParameter = widget:getLayoutParameter()
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 255; g = 0; b = 255})
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 1.0; height = 0.25})
        if widget:getLayoutParameter() ~= layoutParameter then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['bottom'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("bottom")
        end
        
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        return widget
    end)()
    widget:addChild(child)
    return widget
end