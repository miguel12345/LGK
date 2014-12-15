return function(p_actionHandler,p_elements)
    local widget = ccui.Layout:create()
    local layoutParameter = widget:getLayoutParameter()
    widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
    widget:setSizeValues({width = 0.8; height = 0.8})
    layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
    local alignment = ccui.RelativeAlign.centerInParent
    layoutParameter:setAlign(alignment)
    if layoutParameter ~= nil then
    widget:setLayoutParameter(layoutParameter)
end
    local child = (function()
        local widget = require('generated_lgx.IncludeLayoutTestSceneInclude_lgx')(p_actionHandler,p_elements,{})
        local widgetTemp = widget
        widget = p_elements['element']
        local layoutParameter = widget:getLayoutParameter()
        local layoutParameterChanged = false
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 0; g = 255; b = 0})
        if layoutParameterChanged then
    widget:layoutParameterChanged()
end
        widget:setName('greenElement')
        p_elements['greenElement'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("greenElement")
        end
        
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        widget = widgetTemp
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = require('generated_lgx.IncludeLayoutTestSceneInclude_lgx')(p_actionHandler,p_elements,{})
        local widgetTemp = widget
        widget = p_elements['element']
        local layoutParameter = widget:getLayoutParameter()
        local layoutParameterChanged = false
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 255; g = 0; b = 0})
        if layoutParameterChanged then
    widget:layoutParameterChanged()
end
        widget:setName('redElement')
        p_elements['redElement'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("redElement")
        end
        
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        widget = widgetTemp
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = require('generated_lgx.IncludeLayoutTestSceneInclude_lgx')(p_actionHandler,p_elements,{})
        local widgetTemp = widget
        widget = p_elements['element']
        local layoutParameter = widget:getLayoutParameter()
        local layoutParameterChanged = false
        widget:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
        widget:setBackGroundColor({r = 0; g = 0; b = 255})
        if layoutParameterChanged then
    widget:layoutParameterChanged()
end
        widget:setName('blueElement')
        p_elements['blueElement'] = widget
        local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("blueElement")
        end
        
        widget:setLayoutType(ccui.LayoutType.RELATIVE)
        widget = widgetTemp
        return widget
    end)()
    widget:addChild(child)
    widget:setLayoutType(ccui.LayoutType.VERTICAL)
    return widget
end