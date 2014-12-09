lgk = lgk or {}

-- cocos
require "cocos.init"

-- utils
lgk.json = require "lgk.utils.json_utf"
require "lgk.utils.luaExtensions"
require "lgk.utils.stringExtended"

-- xml
lgk.xmlSimple = require "lgk.xml.xmlSimple"
require "lgk.xml.XMLScene"
require "lgk.xml.XMLParser"

-- layout
require "lgk.inflation.LayoutUtils"
require "lgk.inflation.WidgetAttributeInflater"
require "lgk.inflation.WidgetInflater"
require "lgk.inflation.LayoutInflater"

-- animation
require "lgk.animation.Transition"
require "lgk.animation.TransitionInflater"

-- scene
require "lgk.scene.LGKScene"

-- network
require "lgk.network.JSONRequest"

-- widgets
require "lgk.widgets.LazyListView"
require "lgk.widgets.ImageViewExtended"
require "lgk.widgets.PageViewExtended"

lgk.getLGKVersion = function()
    return "0.5.0"
end