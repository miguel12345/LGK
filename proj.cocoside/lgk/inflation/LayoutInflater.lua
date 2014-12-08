
lgk = lgk or {}
local XmlParser = lgk.XMLParser
local LayoutInflater = {};

---
--@function [parent=#src.LayoutInflater] inflateXMLFile
--@param filePath string absolute or relative file path
--@param handler #table The action handler
--@return Node#Node root node from parsed xml 
function LayoutInflater:inflateXMLFile(filePath,handler,context) 
    local fileUtils = cc.FileUtils:getInstance();  
    local xmlFilePath = cc.FileUtils:getInstance():fullPathForFilename(filePath)
    local xmlContent = cc.FileUtils:getInstance():getStringFromFile(xmlFilePath) 
    
    if xmlContent == "" then
        return false
    end
    
    local layout = XmlParser:parseXML(xmlContent)
    local layoutNode = self:parseNode(layout:children()[1],handler,context)
    return layoutNode
end

local function applyContextToXMLProperties(xmlProperties,context)

    if context then
        --[[
            Context example:
            {
                ElementName : {
                text : "Ola"
                }
            }
        
            XML properties example:
            {
                ...,
                "@name" : "ElementName",
                ...
            }
        ]]
    
        local nodeName = xmlProperties["@name"] 
          
        if nodeName and context[nodeName] then
            for propertyName, propertyValue in pairs(context[nodeName]) do
                    xmlProperties["@" .. propertyName] = propertyValue 
            end
        end
    end
    
    return xmlProperties    
end

---
--@function [parent=#src.LayoutInflater] parseNode
--@return Node#Node description
function LayoutInflater:parseNode(xmlNode,handler,context) 
    local widgetInflater = lgk.WidgetInflater
    local widgetName = xmlNode:name()
    xmlNode = applyContextToXMLProperties(xmlNode,context)
    local cocosNode = widgetInflater.inflateFromXMLNode(widgetName,xmlNode,handler)
    
    -- elements table for fast access
    if cocosNode:getName() ~= nil then
        local elementsWeakTable = handler.elements or setmetatable({}, {__mode="v"})
        elementsWeakTable[cocosNode:getName()] = cocosNode
        handler.elements = elementsWeakTable
    end
    
    local children = xmlNode:children()
    for i, child in ipairs(children) do
        local cocosChildNode = self:parseNode(child,handler,context)
        cocosNode:addChild(cocosChildNode)
    end
    
    return cocosNode
end

lgk.LayoutInflater = LayoutInflater;