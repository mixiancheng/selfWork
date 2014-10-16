
require "Cocos2d"
require "Opengl"
require "OpenglConstants"
-- cclog
cclog = function(...)
    print(string.format(...))
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
    cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(1024,768, 2)
    cc.FileUtils:getInstance():addSearchPath("src");
    cc.FileUtils:getInstance():addSearchPath("src/pb");
    cc.FileUtils:getInstance():addSearchPath("src/protobuf");
    cc.FileUtils:getInstance():addSearchPath("src/net");
    cc.FileUtils:getInstance():addSearchPath("src/ui");
    cc.FileUtils:getInstance():addSearchPath("src/util");
    cc.FileUtils:getInstance():addSearchPath("src/game");
    cc.FileUtils:getInstance():addSearchPath("res")
    cc.FileUtils:getInstance():addSearchPath("res/DemoLogin");
    cc.FileUtils:getInstance():addSearchPath("res/publish");
    cc.FileUtils:getInstance():addSearchPath("res/gameui");
    cc.FileUtils:getInstance():addSearchPath("res/icons");
    require "GameControl"
    require "Config"
    intiRule()
    initIconImg()
--    local schedulerID = 0
    --support debug
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) or 
        (cc.PLATFORM_OS_ANDROID == targetPlatform) or (cc.PLATFORM_OS_WINDOWS == targetPlatform) or
        (cc.PLATFORM_OS_MAC == targetPlatform) then
    --        cclog("result is ")
    --require('debugger')()

    end
--    require "GameLayer"
--    testGameLayer()
--    require "src/protobuf/protocTest"
--    TestPb_rep()
    --    require "Resource"
    --    Resource.update()
--    require "HelloScene"
--    runCocosHelloScene()
    --      require "testPb"
    --      testPb()
    _rule= require("Rules")
    require "GameView"
    CreatGameView()
--    local num=_rule.getLine(2,0)
--    cclog("num"..num)
end
function GoInGame()
    require "Login"
    runCocosLoginScene()
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
