lgk = lgk or {}

-- cocos
require "cocos.init"

-- utils
lgk.json = require "lgk.utils.json_utf"
require "lgk.utils.luaExtensions"
require "lgk.utils.stringExtended"

-- animation
require "lgk.animation.Transition"

-- scene
require "lgk.scene.LGKScene"

-- network
require "lgk.network.JSONRequest"

-- widgets
require "lgk.widgets.LazyListView"
require "lgk.widgets.ImageViewExtended"

lgk.getLGKVersion = function()
    return "0.5.0"
end