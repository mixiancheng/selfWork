require "Cocos2d"
require "Cocos2dConstants"
require "Opengl"
require "OpenglConstants"
-- cclog
cclog = function(...)
    print(string.format(...))
end
debugLog=function(...)
cclog(...)
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
    cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(640, 960, 2)
	cc.FileUtils:getInstance():addSearchResolutionsOrder("src");
    cc.FileUtils:getInstance():addSearchResolutionsOrder("src/ui");
    cc.FileUtils:getInstance():addSearchResolutionsOrder("src/rule");
	cc.FileUtils:getInstance():addSearchResolutionsOrder("res");
    cc.FileUtils:getInstance():addSearchResolutionsOrder("res/ui");
    cc.FileUtils:getInstance():addSearchResolutionsOrder("res/mapData");
    cc.FileUtils:getInstance():addSearchResolutionsOrder("src/config")
    cc.FileUtils:getInstance():addSearchResolutionsOrder("src/obj")
    cc.FileUtils:getInstance():addSearchResolutionsOrder("res/obj")
    require "GameControl"
--    beginTick()
	local schedulerID = 0
    --support debug
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) or 
       (cc.PLATFORM_OS_ANDROID == targetPlatform) or (cc.PLATFORM_OS_WINDOWS == targetPlatform) or
       (cc.PLATFORM_OS_MAC == targetPlatform) then
--        cclog("result is ")
		--require('debugger')()
        
    end
--   local _len= ccpDistance(cc.p(2,2),cc.p(3,3))
--    cclog("lendd---->%d",_len)
--    require "ObjsRule"
--    ObjsRule:OnTouch(0,0)
--    local _config=require("Config")
--    cclog("mapw===%d",_config.MapCol)
    require "MainMenuScene"
    runMainMenuScene()
--    require "TestLayer"
--    creatTestSceen()
    ---------------
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local origin = cc.Director:getInstance():getVisibleOrigin()
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
