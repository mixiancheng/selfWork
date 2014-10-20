require "CCBReaderLoad"
require "luaRes/UserDefault"
cclog = function(...)
    print(string.format(...))
end
local layer = nil
LoginLayer = LoginLayer or {}
ccb["LoginLayer"] = LoginLayer
local function buttonLogin()
    -- AudioEngine.stopMusic()
AudioEngine.playEffect("music/buttonchild.wav")
CCUserDefault:sharedUserDefault():setStringForKey(saveData.userName, "1001")
CCUserDefault:sharedUserDefault():flush()
local s = runWorldMapLayer()
CCDirector:sharedDirector():replaceScene(s)
end
LoginLayer["buttonLogin"]=buttonLogin
local function _LoginLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    local  node  = CCBuilderReaderLoad("ccbi/LoginLayer.ccbi",proxy,LoginLayer)
    layer = tolua.cast(node,"CCLayer")
    playBackMusic("music/background.mp3", true)
    return layer
end
function runLoginLayer()
    cclog("LogoLayer")
    local scene = CCScene:create()
    scene:addChild(_LoginLayer())
    return scene
end