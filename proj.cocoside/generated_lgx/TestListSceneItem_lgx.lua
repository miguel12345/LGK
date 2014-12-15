return function(p_actionHandler,p_elements)
    local widget = ccui.Button:create('')
    local layoutParameter = widget:getLayoutParameter()
    widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
    widget:setSizeValues({width = 200; height = 80})
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
    local handlerFunction = function(sender,eventType)
                                        if eventType == ccui.TouchEventType.ended then
                                            p_actionHandler["clickedElement"](p_actionHandler,widget,eventType)
                                        end
                                    end
                                    widget:addTouchEventListener(handlerFunction)
    return widget
end