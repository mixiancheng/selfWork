
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
    
    require("AppMacro")

    tgInitGlobalVar()

    require("LoginScene")
    tgEnterScene(createLogin())

--    require("TestScene")
--    tgEnterScene(createTest())
end

function GoInGame()
    require "Login"
    runCocosLoginScene()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
