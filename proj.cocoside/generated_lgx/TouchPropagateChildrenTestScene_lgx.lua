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
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 255; g = 0; b = 0; a = 255})
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 0.5; height = 0.5})
        layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
        local alignment = ccui.RelativeAlign.centerInParent
        layoutParameter:setAlign(alignment)
        if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
        widget:setPropagateTouchEventsToChildren(true)
        p_elements['parent'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("parent")
        end
        
        local child = (function()
            local widget =  ccui.Text:create('Text 1','Helvetica',20)
            local layoutParameter = widget:getLayoutParameter()
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.absolute)
            widget:setSizeValues({width = 0.4; height = -1})
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentLeftBottom
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
            p_elements['child1'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("child1")
        end
        
            widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)  
        widget:setAdaptFontSizeToFit(true)
        
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget =  ccui.Text:create('Text 2','Helvetica',20)
            local layoutParameter = widget:getLayoutParameter()
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.absolute)
            widget:setSizeValues({width = 0.4; height = -1})
            layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
            local alignment = ccui.RelativeAlign.alignParentRightBottom
            layoutParameter:setAlign(alignment)
            if layoutParameter ~= nil then
            widget:setLayoutParameter(layoutParameter)
        end
            p_elements['child2'] = widget
            local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("child2")
        end
        
            widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)  
        widget:setAdaptFontSizeToFit(true)
        
            return widget
        end)()
        widget:addChild(child)
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        return widget
    end)()
    widget:addChild(child)
    return widget
end