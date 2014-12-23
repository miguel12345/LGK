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
        
    widget:setLayoutType(ccui.LayoutType.HORIZONTAL)
    local child = (function()
        local widget = ccui.Layout:create()
        widget:setCascadeOpacityEnabled(true)
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 0.333; height = 1.0})
        widget:setLayoutType(ccui.LayoutType.VERTICAL)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 1.0; height = 0.3})
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            local child = (function()
                local widget = lgk.ImageViewExtended.create()
                widget:ignoreContentAdaptWithSize(false)
                widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
                widget:setSizeValues({width = 1.0; height = 1.0})
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                p_elements['imageViewAspectFill1'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("imageViewAspectFill1")
        end
        
                widget:loadTexture('images/square-image.jpg')
                widget:setContentMode(ccui.ImageView.ContentMode.aspectFill)
                return widget
            end)()
            widget:addChild(child)
            local child = (function()
                local widget =  ccui.Text:create('AspectFill','Helvetica',40)
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
                widget:setTextColor({r = 0; g = 0; b = 0; a = 255})
                return widget
            end)()
            widget:addChild(child)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 1.0; height = 0.3})
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            local child = (function()
                local widget = lgk.ImageViewExtended.create()
                widget:ignoreContentAdaptWithSize(false)
                widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
                widget:setSizeValues({width = 1.0; height = 1.0})
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                p_elements['imageViewScaleToFit1'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("imageViewScaleToFit1")
        end
        
                widget:loadTexture('images/square-image.jpg')
                widget:setContentMode(ccui.ImageView.ContentMode.scaleToFit)
                return widget
            end)()
            widget:addChild(child)
            local child = (function()
                local widget =  ccui.Text:create('ScaleToFit','Helvetica',40)
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
                widget:setTextColor({r = 0; g = 0; b = 0; a = 255})
                return widget
            end)()
            widget:addChild(child)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 1.0; height = 0.3})
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            local child = (function()
                local widget = lgk.ImageViewExtended.create()
                widget:ignoreContentAdaptWithSize(false)
                widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
                widget:setSizeValues({width = 1.0; height = 1.0})
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                p_elements['imageViewAspectFit1'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("imageViewAspectFit1")
        end
        
                widget:loadTexture('images/square-image.jpg')
                widget:setContentMode(ccui.ImageView.ContentMode.aspectFit)
                return widget
            end)()
            widget:addChild(child)
            local child = (function()
                local widget =  ccui.Text:create('AspectFit','Helvetica',40)
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
                widget:setTextColor({r = 0; g = 0; b = 0; a = 255})
                return widget
            end)()
            widget:addChild(child)
            return widget
        end)()
        widget:addChild(child)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = ccui.Layout:create()
        widget:setCascadeOpacityEnabled(true)
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 0.333; height = 1.0})
        widget:setLayoutType(ccui.LayoutType.VERTICAL)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 1.0; height = 0.3})
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            local child = (function()
                local widget = lgk.ImageViewExtended.create()
                widget:ignoreContentAdaptWithSize(false)
                widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
                widget:setSizeValues({width = 1.0; height = 1.0})
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                p_elements['imageViewAspectFill2'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("imageViewAspectFill2")
        end
        
                widget:loadTexture('images/landscape-image.png')
                widget:setContentMode(ccui.ImageView.ContentMode.aspectFill)
                return widget
            end)()
            widget:addChild(child)
            local child = (function()
                local widget =  ccui.Text:create('AspectFill','Helvetica',40)
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
                widget:setTextColor({r = 0; g = 0; b = 0; a = 255})
                return widget
            end)()
            widget:addChild(child)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 1.0; height = 0.3})
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            local child = (function()
                local widget = lgk.ImageViewExtended.create()
                widget:ignoreContentAdaptWithSize(false)
                widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
                widget:setSizeValues({width = 1.0; height = 1.0})
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                p_elements['imageViewScaleToFit2'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("imageViewScaleToFit2")
        end
        
                widget:loadTexture('images/landscape-image.png')
                widget:setContentMode(ccui.ImageView.ContentMode.scaleToFit)
                return widget
            end)()
            widget:addChild(child)
            local child = (function()
                local widget =  ccui.Text:create('ScaleToFit','Helvetica',40)
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
                widget:setTextColor({r = 0; g = 0; b = 0; a = 255})
                return widget
            end)()
            widget:addChild(child)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 1.0; height = 0.3})
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            local child = (function()
                local widget = lgk.ImageViewExtended.create()
                widget:ignoreContentAdaptWithSize(false)
                widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
                widget:setSizeValues({width = 1.0; height = 1.0})
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                p_elements['imageViewAspectFit2'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("imageViewAspectFit2")
        end
        
                widget:loadTexture('images/landscape-image.png')
                widget:setContentMode(ccui.ImageView.ContentMode.aspectFit)
                return widget
            end)()
            widget:addChild(child)
            local child = (function()
                local widget =  ccui.Text:create('AspectFit','Helvetica',40)
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
                widget:setTextColor({r = 0; g = 0; b = 0; a = 255})
                return widget
            end)()
            widget:addChild(child)
            return widget
        end)()
        widget:addChild(child)
        return widget
    end)()
    widget:addChild(child)
    local child = (function()
        local widget = ccui.Layout:create()
        widget:setCascadeOpacityEnabled(true)
        widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
        widget:setSizeValues({width = 0.333; height = 1.0})
        widget:setLayoutType(ccui.LayoutType.VERTICAL)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 1.0; height = 0.3})
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            local child = (function()
                local widget = lgk.ImageViewExtended.create()
                widget:ignoreContentAdaptWithSize(false)
                widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
                widget:setSizeValues({width = 1.0; height = 1.0})
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                p_elements['imageViewAspectFill3'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("imageViewAspectFill3")
        end
        
                widget:loadTexture('images/portrait-image.png')
                widget:setContentMode(ccui.ImageView.ContentMode.aspectFill)
                return widget
            end)()
            widget:addChild(child)
            local child = (function()
                local widget =  ccui.Text:create('AspectFill','Helvetica',40)
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
                widget:setTextColor({r = 0; g = 0; b = 0; a = 255})
                return widget
            end)()
            widget:addChild(child)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 1.0; height = 0.3})
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            local child = (function()
                local widget = lgk.ImageViewExtended.create()
                widget:ignoreContentAdaptWithSize(false)
                widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
                widget:setSizeValues({width = 1.0; height = 1.0})
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                p_elements['imageViewScaleToFit3'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("imageViewScaleToFit3")
        end
        
                widget:loadTexture('images/portrait-image.png')
                widget:setContentMode(ccui.ImageView.ContentMode.scaleToFit)
                return widget
            end)()
            widget:addChild(child)
            local child = (function()
                local widget =  ccui.Text:create('ScaleToFit','Helvetica',40)
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
                widget:setTextColor({r = 0; g = 0; b = 0; a = 255})
                return widget
            end)()
            widget:addChild(child)
            return widget
        end)()
        widget:addChild(child)
        local child = (function()
            local widget = ccui.Layout:create()
            widget:setCascadeOpacityEnabled(true)
            widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
            widget:setSizeValues({width = 1.0; height = 0.3})
            widget:setLayoutType(ccui.LayoutType.RELATIVE)
            local child = (function()
                local widget = lgk.ImageViewExtended.create()
                widget:ignoreContentAdaptWithSize(false)
                widget:setSizeTypes(ccui.SizeType.percent,ccui.SizeType.percent)
                widget:setSizeValues({width = 1.0; height = 1.0})
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                p_elements['imageViewAspectFit3'] = widget
                local relativeLayoutParameter = widget:getLayoutParameter();
        if relativeLayoutParameter ~= nil and relativeLayoutParameter:getLayoutType() == ccui.LayoutParameterType.relative then
            relativeLayoutParameter:setRelativeName("imageViewAspectFit3")
        end
        
                widget:loadTexture('images/portrait-image.png')
                widget:setContentMode(ccui.ImageView.ContentMode.aspectFit)
                return widget
            end)()
            widget:addChild(child)
            local child = (function()
                local widget =  ccui.Text:create('AspectFit','Helvetica',40)
                local layoutParameter = nil
                layoutParameter = layoutParameter or ccui.RelativeLayoutParameter:create()
                local alignment = ccui.RelativeAlign.centerInParent
                layoutParameter:setAlign(alignment)
                if layoutParameter ~= nil then
                    widget:setLayoutParameter(layoutParameter)
                end
                widget:ignoreContentAdaptWithSize(false)
        widget:setAdaptLabelScaleWithContentSize(false)
        widget:setAdaptFontSizeToFit(false)
        widget:setContentSize({width=0;height=0})
        
                widget:setTextColor({r = 0; g = 0; b = 0; a = 255})
                return widget
            end)()
            widget:addChild(child)
            return widget
        end)()
        widget:addChild(child)
        return widget
    end)()
    widget:addChild(child)
    return widget
end