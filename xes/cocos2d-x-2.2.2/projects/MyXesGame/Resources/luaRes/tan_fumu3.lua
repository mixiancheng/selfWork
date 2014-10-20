require "CCBReaderLoad"
cclog = function(...)
    print(string.format(...))
end
local layer = nil
tan_fumu3 = tan_fumu3 or {}
ccb["tan_fumu3"] = tan_fumu3
local function buttonLExit(  )
    -- body
     AudioEngine.stopAllEffects()
AudioEngine.playEffect("music/buttonchild.wav")
local s = runWorldMapLayer()
CCDirector:sharedDirector():replaceScene(s)
end
local function buttonRExit(  )
    -- body
     AudioEngine.stopAllEffects()
AudioEngine.playEffect("music/buttonchild.wav")
local s = runWorldMapLayer()
CCDirector:sharedDirector():replaceScene(s)
end
local function buttonLRgame(  )
    -- body
     cclog("buttonRgame------->")
    AudioEngine.stopAllEffects()
AudioEngine.playEffect("music/buttonchild.wav")
local s = runTest()
CCDirector:sharedDirector():replaceScene(s)
end
local function buttonRRgame(  )
    -- body
     cclog("buttonRgame------->")
    AudioEngine.stopAllEffects()
AudioEngine.playEffect("music/buttonchild.wav")
local s = runTest()
CCDirector:sharedDirector():replaceScene(s)
end
local function buttonBack()
    cclog("buttonBack------->")
    AudioEngine.stopAllEffects()
AudioEngine.playEffect("music/buttonchild.wav")
local s = runWorldMapLayer()
CCDirector:sharedDirector():replaceScene(s)
end
local function buttonRgame( )
    -- body
    cclog("buttonRgame------->")
    AudioEngine.stopAllEffects()
AudioEngine.playEffect("music/buttonchild.wav")
local s = runTest()
CCDirector:sharedDirector():replaceScene(s)
end

tan_fumu3["LExit"]=buttonLExit
tan_fumu3["LRgame"]=buttonLRgame
tan_fumu3["RRgame"]=buttonRRgame
tan_fumu3["RExit"]=buttonRExit
local function _tan_fumu3Layer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    local  node  = CCBuilderReaderLoad("ccbi/tan_fumu3.ccbi",proxy,tan_fumu3)
    layer = tolua.cast(node,"CCLayer")
    local m_label0 =tolua.cast(tan_fumu3["shuDDMesgL"],"CCLabelTTF")
    m_label0:setString(shuDD.."个")
    local m_label1 =tolua.cast(tan_fumu3["jinDDMesgL"],"CCLabelTTF")
    m_label1:setString(jinDD.."个")
    m_label0 =tolua.cast(tan_fumu3["shuDDMesgR"],"CCLabelTTF")
    m_label0:setString(shuDD.."个")
    m_label1 =tolua.cast(tan_fumu3["jinDDMesgR"],"CCLabelTTF")
    m_label1:setString(jinDD.."个")

    playBackMusic("music/background.mp3", true)
    AudioEngine.playEffect("music/vioceparents3.mp3")
    return layer
end
function runtan_fumu3Layer()
    cclog("LogoLayer")
    local scene = CCScene:create()
    scene:addChild(_tan_fumu3Layer())
    return scene
end