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
require "lgk.layout.LayoutUtils"
require "lgk.layout.LayoutNodeInflater"
require "lgk.layout.LayoutInflater"

-- scene
require "lgk.scene.LGKScene"

-- transition
require "lgk.animation.LayoutTransitionManager"

-- network
require "lgk.network.JSONRequest"

-- widgets
require "lgk.widgets.LazyListView"
require "lgk.widgets.ImageViewExtended"
require "lgk.widgets.PageViewExtended"

lgk.getLGKVersion = function()
    return "0.5.0"
end