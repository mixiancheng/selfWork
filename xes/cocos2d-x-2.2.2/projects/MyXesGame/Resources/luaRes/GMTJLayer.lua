require "CCBReaderLoad"
cclog = function(...)
    print(string.format(...))
end
local layer = nil
GMTJLayer = GMTJLayer or {}
ccb["GMTJLayer"] = GMTJLayer
local function LoadFinsh()
    cclog("进入大地图")
    local nextLayer = rungameLoadingLayer()
    CCDirector:sharedDirector():replaceScene(nextLayer)
end
local function buttonStart()
local s = runGame1Layer()
CCDirector:sharedDirector():replaceScene(s)
end
local function buttonBack( )
    -- body
    local s = runWorldMapLayer()
CCDirector:sharedDirector():replaceScene(s)
end

GMTJLayer["buttonStart"]=buttonStart
GMTJLayer["buttonBack"]=buttonBack
local function _GMTJLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    local  node  = CCBuilderReaderLoad("ccbi/GMTJLayer.ccbi",proxy,GMTJLayer)
    layer = tolua.cast(node,"CCLayer")
    local str=string.format("%2.1f", QZGameTimer)
    local  m_label1 = CCLabelBMFont:create(str, "fonts/bitmapFontTest4.fnt")
    m_label1:setPositionX(650)
    m_label1:setPositionY(550)
    m_label1:setAnchorPoint(ccp(0.5,0.5))
    -- m_label1:setVisible(false)
    -- m_label1:setRotation(270)
    layer:addChild(m_label1)
    return layer
end
function runGMTJLayer()
    cclog("LogoLayer")
    local scene = CCScene:create()
    scene:addChild(_GMTJLayer())
    return scene
end