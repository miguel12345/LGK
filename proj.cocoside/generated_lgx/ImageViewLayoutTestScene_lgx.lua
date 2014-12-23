return function(p_actionHandler,p_elements)
    local widget = ccui.Layout:create()
    widget:setCascadeOpacityEnabled(true)
    widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.absolute)
    widget:setSizeValues({width = 1.0; height = 400})
    local layoutParameter = nil
    layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
    local alignment = ccui.RelativeAlign.centerInParent
    layoutParameter:setAlign(alignment)
    widget:setLogLayout(true)
    if layoutParameter ~= nil then
        widget:setLayoutParameter(layoutParameter)
    end
    p_elements['imageParent'] = widget
    local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("imageParent")
        end
        
    widget:setLayoutType(ccui.LayoutType.RELATIVE)
    local child = (function()
        local widget = lgk.ImageViewExtended.create()
        widget:ignoreContentAdaptWithSize(false)
        widget:setSizeTypes(ccui.SizeType.absolute,ccui.SizeType.absolute)
        widget:setSizeValues({width = 200; height = 200})
        local layoutParameter = nil
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        p_elements['image'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("image")
        end
        
        widget:loadTexture('farm.jpg')
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
        layoutParameter:setMargin({left = 0;right = 0;top = 0;bottom = 50;})
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setTitleText('Switch Image')
        widget:setTitleFontSize(30)
        widget:setTouchEnabled(true)
        widget:addTouchEventListener(function(widget,touchType)
            if(touchType == ccui.TouchEventType.ended or touchType == ccui.TouchEventType.canceled) then
                if touchType == ccui.TouchEventType.ended then
                            p_actionHandler['switchImageTexture'](p_actionHandler,widget)
                end
            end
        end)
        return widget
    end)()
    widget:addChild(child)
    return widget
end