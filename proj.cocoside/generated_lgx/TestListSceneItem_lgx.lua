return function(p_actionHandler,p_elements)
    local widget = ccui.Button:create('')
    widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
    widget:setSizeValues({width = 200; height = 80})
    local layoutParameter = nil
    layoutParameter = layoutParameter or ccui.LinearLayoutParameter:create()
    layoutParameter:setGravity(ccui.LinearGravity.centerHorizontal)
    if layoutParameter ~= nil then
        widget:setLayoutParameter(layoutParameter)
    end
    p_elements['item'] = widget
    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("item")
        end
        
    widget:ignoreContentAdaptWithSize(false)
    widget:setTitleText('')
    widget:setTitleFontSize(40)
    widget:setTouchEnabled(true)
    widget:addTouchEventListener(function(widget,touchType)
        if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
            if touchType == ccui.TouchEventType.ended then
                    p_actionHandler['clickedElement'](p_actionHandler,widget)
            end
        end
    end)
    return widget
end