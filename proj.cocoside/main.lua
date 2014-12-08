require "lgk.init"

cc.FileUtils:getInstance():addSearchPath("tests")
cc.FileUtils:getInstance():addSearchPath("tests/src")
cc.FileUtils:getInstance():addSearchPath("tests/res")
cc.FileUtils:getInstance():addSearchPath("tests/res/fonts")
cc.FileUtils:getInstance():addSearchPath("tests/res/images")
cc.FileUtils:getInstance():addSearchPath("tests/res/xml")


local cclog = function(...)
    print(string.format(...))
end

-- improve assert

testassert = function(cond,msg)
    
    local resultString = "FAILED"
    local status, err = pcall(assert,cond,msg)
    if status then
        resultString = "OK"
    end
    print("[TEST] " .. resultString .. " - " .. msg)
    if not status then
        assert(cond,msg)
    end
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    -- initialize director
    local director = cc.Director:getInstance()

    --turn on display FPS
    director:setDisplayStats(true)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(1.0 / 60)

--    print("Cocos version ".. cc.getCocosVersion())
--    print("LGK version ".. lgk.getLGKVersion())
    
    local layoutInflater = lgk.LayoutInflater
    local scene = nil
    if require("tests").getCurrentTest()~=nil then
        scene = require(require("tests").getCurrentTest()).create()
    else
        scene = require("TestListScene").create() 
    end
    
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(scene)
    else
        cc.Director:getInstance():runWithScene(scene)
    end
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
