
lgk = lgk or {}

function propIndexFromName(name)
    return "@" .. name
end

local widgetInflater = {}
local layoutUtils = lgk.LayoutUtils
local widgetAttributeInflater = lgk.WidgetAttributeInflater

widgetInflater.inflateLayout = function(xmlNode,actionHandler,elements)
    
    local layout = ccui.Layout:create()
    widgetAttributeInflater.inflateLayoutAttributes(layout,xmlNode,elements)
    
    local children = xmlNode:children()
    for i, child in ipairs(children) do
        local childElementRef = widgetInflater.inflateFromXMLNode(child,actionHandler,elements)
        layout:addChild(childElementRef)
    end
    
    return layout
end;

widgetInflater.inflateRootLayout = function(xmlNode,actionHandler,elements)
    local layoutUtils = lgk.LayoutUtils
    local layout = ccui.Layout:create()
    local screenSize = cc.Director:getInstance():getWinSize()
    
    layout:setPosition(0,0)
    layout:setContentSize(screenSize)

    --layout type
    local layoutType = xmlNode["@type"] 
    layout:setLayoutType(layoutUtils:getLayoutTypeFromString(layoutType))
    
    layout:setSizeType(ccui.SizeType.percent)
    layout:setSizePercent({x=1.0;y=1.0})
    layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
    layout:setBackGroundColor({r = 0; g = 0; b = 120})
    
    widgetAttributeInflater.inflateCommonAttributes(layout,xmlNode,elements)
    
    local children = xmlNode:children()
    for i, child in ipairs(children) do
        local childElementRef = widgetInflater.inflateFromXMLNode(child,actionHandler,elements)
        layout:addChild(childElementRef)
    end

    return layout
end;

widgetInflater.inflateText = function(xmlNode,actionHandler,elements)
    local layoutUtils = lgk.LayoutUtils
    local fontName = xmlNode["@font"] or "Helvetica"
    local fontSize = tonumber(xmlNode["@fontSize"] or "20")
    local text = xmlNode["@text"] or ""
    local textLayout = ccui.Text:create(text,fontName,fontSize)
    if xmlNode["@shadow"] == "true" or (xmlNode["@shadow"] == nil and (xmlNode["@shadowColor"]~=nil or xmlNode["@shadowOffset"]~=nil)) then
        textLayout:enableShadow(layoutUtils:getColorFromString(xmlNode["@shadowColor"]) or {r=0;g=0;b=0;a=255},layoutUtils:getSizeFromString(xmlNode["@shadowOffset"]) or cc.size(2.0,-2.0))
    end
    
    widgetAttributeInflater.inflateWidgetAttributes(textLayout,xmlNode,elements)
    
    if xmlNode["@size"] == nil then
        textLayout:ignoreContentAdaptWithSize(false)
        textLayout:setAdaptLabelScaleWithContentSize(false)
        textLayout:setAdaptFontSizeToFit(false)
        textLayout:setContentSize({width=0;height=0})
    elseif xmlNode["@fontSize"] == nil then
        textLayout:ignoreContentAdaptWithSize(false)
        textLayout:setAdaptLabelScaleWithContentSize(false)  
        textLayout:setAdaptFontSizeToFit(true)
    else
        local size = layoutUtils:getSizeFromString(xmlNode["@size"])
        if size.height == 0 or size.width == 0 then
            textLayout:setAdaptLabelScaleWithContentSize(false)  
        else
            textLayout:setAdaptLabelScaleWithContentSize(true)
        end
        textLayout:ignoreContentAdaptWithSize(false)
        textLayout:setAdaptFontSizeToFit(false)
    end
    
    if xmlNode["@drawDebug"]=="true" then
        textLayout:setDebugDraw(true)
    end
    
    if xmlNode["@wrap"] == "word" then
        textLayout:setLineBreakWithoutSpace(false)
    elseif xmlNode["@wrap"] == "character" then
        textLayout:setLineBreakWithoutSpace(true)
    end
    
    if xmlNode["@textColor"] ~= nil then
        textLayout:setTextColor(layoutUtils:getColorFromString(xmlNode["@textColor"]))
    end
        
    return textLayout
end;

widgetInflater.inflateButton = function(xmlNode,actionHandler,elements)
    local buttonImage = xmlNode["@image"] or ""
    local buttonLayout = ccui.Button:create(buttonImage)
    widgetAttributeInflater.inflateWidgetAttributes(buttonLayout,xmlNode,elements)
    
    if xmlNode["@size"] or  xmlNode["@sizePercent"] then
        buttonLayout:ignoreContentAdaptWithSize(false)
    end
    
    if xmlNode["@text"] then
        buttonLayout:setTitleText(xmlNode["@text"])
    end
    
    if xmlNode["@fontSize"] then
        buttonLayout:setTitleFontSize(xmlNode["@fontSize"])
    end
    
    if xmlNode["@fontName"] then
        buttonLayout:setTitleFontName(xmlNode["@fontName"])
    end
    
    local onClickAction = xmlNode["@onClick"]
    if onClickAction then
        local handlerFunction = function(sender,eventType)
            if eventType == ccui.TouchEventType.ended then
                actionHandler[onClickAction](actionHandler,buttonLayout,eventType)
            end
        end

    buttonLayout:addTouchEventListener(handlerFunction)
    
    end
    
    return buttonLayout
end;


widgetInflater.inflateListView = function(xmlNode,actionHandler,elements)
    local direction = xmlNode["@direction"] and ccui.ListViewDirection[xmlNode["@direction"]] or ccui.ListViewDirection.vertical
    local backgroundImage = xmlNode["@backgroundImage"]
    local listViewLayout = ccui.ListView:create()
    
    widgetAttributeInflater.inflateLayoutAttributes(listViewLayout,xmlNode,elements)
    
    listViewLayout:setDirection(direction)
    if backgroundImage ~= nil then listViewLayout:setBackGroundImage(backgroundImage) end
    
    local children = xmlNode:children()
    for i, child in ipairs(children) do
        local childElementRef = widgetInflater.inflateFromXMLNode(child,actionHandler,elements)
        listViewLayout:addChild(childElementRef)
    end
    
    return listViewLayout
end;


widgetInflater.inflateScrollView = function(xmlNode,actionHandler,elements)
    local direction = xmlNode["@direction"] and ccui.ScrollViewDir[xmlNode["@direction"]] or ccui.ScrollViewDir.vertical
    local scrollViewLayout = ccui.ScrollView:create()
    scrollViewLayout:setDirection(direction)
    scrollViewLayout:setInnerContainerSize({width = 100; height = 400})
    widgetAttributeInflater.inflateLayoutAttributes(scrollViewLayout,xmlNode)
    
    local children = xmlNode:children()
    for i, child in ipairs(children) do
        local childElementRef = widgetInflater.inflateFromXMLNode(child,actionHandler,elements)
        scrollViewLayout:addChild(childElementRef)
    end
    
    return scrollViewLayout
end;

local imageViewContentModeMap = {
    ScaleToFit = ccui.ImageView.ContentMode.scaleToFit;
    AspectFit = ccui.ImageView.ContentMode.aspectFit;
    AspectFill = ccui.ImageView.ContentMode.aspectFill;
    Repeat = ccui.ImageView.ContentMode.repeating;
}

widgetInflater.inflateImageView = function(xmlNode,actionHandler,elements)
    local imageUrl = xmlNode["@imageUrl"]
    local imagePath = xmlNode["@image"]
    local imageViewLayout = lgk.ImageViewExtended.create()
    if xmlNode["@size"] then
        imageViewLayout:ignoreContentAdaptWithSize(false)
    end
    
    widgetAttributeInflater.inflateWidgetAttributes(imageViewLayout,xmlNode,elements)
    if imageUrl ~= nil then
        imageViewLayout:setRemoteImage(imageUrl)
    elseif imagePath ~= nil then
        imageViewLayout:loadTexture(imagePath)
    end
    
    if xmlNode["@contentMode"] ~= nil then
        imageViewLayout:setContentMode(imageViewContentModeMap[xmlNode["@contentMode"]])
    end
    
    return imageViewLayout
end;

widgetInflater.inflateLazyListView = function(xmlNode,actionHandler,elements) 
    local lazyListView = gk.LazyListView.create()
    widgetAttributeInflater.inflateLayoutAttributes(lazyListView,xmlNode)
    
    local children = xmlNode:children()
    for i, child in ipairs(children) do
        local childElementRef = widgetInflater.inflateFromXMLNode(child,actionHandler,elements)
        lazyListView:addChild(childElementRef)
    end
    
    return lazyListView
end;


widgetInflater.inflateTextField = function(xmlNode,_,elements) 
    local textField = ccui.TextField:create("Teste","fonts/Marker Felt.ttf",20)
    widgetAttributeInflater.inflateWidgetAttributes(textField,xmlNode,elements)
    return textField
end;

widgetInflater.inflateWebView = function(xmlNode,_,elements)
    local webView = ccexp.WebView:create()
    widgetAttributeInflater.inflateWidgetAttributes(webView,xmlNode,elements)
    webView:ignoreContentAdaptWithSize(false)
    webView:loadURL("http://www.google.com")
    
    return webView
end

widgetInflater.inflatePageView = function(xmlNode,actionHandler,elements)
    local pageView = ccui.PageView:create()
    widgetAttributeInflater.inflateLayoutAttributes(pageView,xmlNode,elements)
    pageView:setCustomScrollThreshold(30.0)
    
    local children = xmlNode:children()
    for i, child in ipairs(children) do
        local childElementRef = widgetInflater.inflateFromXMLNode(child,actionHandler,elements)
        pageView:addPage(childElementRef)
    end
    
    return pageView
end


-- aliases

widgetInflater.inflateRelativeLayout = function(xmlNode,actionHandler,elements)
    local layout = widgetInflater.inflateLayout(xmlNode,actionHandler,elements)
    layout:setLayoutType(ccui.LayoutType.RELATIVE)
    return layout
end;

widgetInflater.inflateVerticalLayout = function(xmlNode,actionHandler,elements)
    local layout = widgetInflater.inflateLayout(xmlNode,actionHandler,elements)
    layout:setLayoutType(ccui.LayoutType.VERTICAL)
    return layout
end;

widgetInflater.inflateHorizontalLayout = function(xmlNode,actionHandler,elements)
    local layout = widgetInflater.inflateLayout(xmlNode,actionHandler,elements)
    layout:setLayoutType(ccui.LayoutType.HORIZONTAL)
    return layout
end

widgetInflater.inflateGridLayout = function(xmlNode,actionHandler,elements)
    local layout = widgetInflater.inflateLayout(xmlNode,actionHandler,elements)
    layout:setLayoutType(ccui.LayoutType.GRID)
    return layout
end


-- include
--[[

    Example
    
    <include file="<name>.xml">
        <Update name="<included_element_name>" ...></Update>  
    </include>
    
]]

widgetInflater.inflateInclude = function(xmlNode,handler,elements)
    
    -- include is a special case
    
    -- first, we check if the file exists
    local includeFileName = xmlNode["@file"]
    local xmlFilePath = cc.FileUtils:getInstance():fullPathForFilename(includeFileName)
    
    assert(xmlFilePath~=includeFileName,"Include : Couldn't find file with name " .. includeFileName)
    
    -- create inflation context from children
    local children = xmlNode:children()
    local contextTable = {}
    
    widgetInflater.inflateIncludeContext(xmlNode,handler,contextTable)

    
    -- now we proceed with the file inflation itself
    return lgk.LayoutInflater:inflateXMLFile(xmlFilePath,handler,contextTable)
end

widgetInflater.inflateIncludeContext = function(xmlNode,handler,contextTable)

    local properties = xmlNode:properties()
    for k, v in pairs(properties) do
        local propertyName = v["name"]
        contextTable[propertyName] = xmlNode["@"..propertyName]
    end
    
    return contextTable
end

widgetInflater.inflateFromXMLNode = function(xmlNode,actionHandler,elements)
    local name = xmlNode:name()
    local widgetInflateFunctionName = "inflate"..name
    local inflateFunction = widgetInflater[widgetInflateFunctionName]
    assert(inflateFunction~=nil,"Not function named ".. widgetInflateFunctionName .. " was found to inflate xml node named "..name.."")
    return inflateFunction(xmlNode,actionHandler,elements)
end

lgk.WidgetInflater = { }
lgk.WidgetInflater.inflateFromXMLNode = widgetInflater.inflateFromXMLNode
