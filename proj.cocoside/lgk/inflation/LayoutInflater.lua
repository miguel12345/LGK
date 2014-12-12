
lgk = lgk or {}
local XmlParser = lgk.XMLParser
local LayoutInflater = {};


function LayoutInflater.getXMLStringWithContextApplied(xmlString,context)

    return string.gsub(xmlString,"{{(%w+)}}",function(key)
     assert(context[key]~=nil)
     return context[key] 
     end)
    
end

function LayoutInflater:inflateXMLFile(filePath,handler,context) 
    local fileUtils = cc.FileUtils:getInstance();  
    local xmlFilePath = cc.FileUtils:getInstance():fullPathForFilename(filePath)
    local xmlContent = cc.FileUtils:getInstance():getStringFromFile(xmlFilePath) 
    
    if context~=nil then
        xmlContent = LayoutInflater.getXMLStringWithContextApplied(xmlContent,context)
    end
    
    if xmlContent == "" then
        return false
    end

    -- make sure handler's elements table exists at this point
    handler.elements = handler.elements or setmetatable({}, {__mode="v"})
    
    local xmlNode = XmlParser:parseXML(xmlContent):children()[1]
    
    local widgetInflater = lgk.WidgetInflater
    local xmlRootInflatedRef = widgetInflater.inflateFromXMLNode(xmlNode,handler,handler.elements,context)

    return xmlRootInflatedRef
end


lgk.LayoutInflater = LayoutInflater;