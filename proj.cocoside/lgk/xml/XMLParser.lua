lgk = lgk or {}

local XmlParser = {};

local xml = lgk.xmlSimple.newParser()

function XmlParser:parseXML(xmlText)     
    local parsedXml = xml:ParseXmlText(xmlText)
    return parsedXml
end

lgk.XMLParser = XmlParser