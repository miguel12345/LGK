lgk = lgk or {}

local PageViewExtended = class("PageViewExtended",function()
    return ccui.PageView:create()
end)

function PageViewExtended.create()
    local pageview = PageViewExtended.new()
    return pageview
end

function PageViewExtended:addChild(node)
    self:addPage(node)
end


lgk.PageViewExtended = PageViewExtended