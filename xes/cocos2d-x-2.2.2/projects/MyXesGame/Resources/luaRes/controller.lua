
-- avoid memory leak
collectgarbage("setpause", 100) 
collectgarbage("setstepmul", 5000)
	
require "luaRes/LogoLayer"
require "luaRes/RichLayer"
require "luaRes/GameWinLayer"
require "luaRes/Game2DoubleLayer"
require "luaRes/GMTJLayer"
require "luaRes/Game1Layer"
require "luaRes/tan_baby"
require "luaRes/tan_fumu1"
require "luaRes/tan_fumu2"
require "luaRes/tan_fumu3"
require "luaRes/MvLayer"
----------------


-- run
-- local scene =runScrollViewsLayer()
-- local scene =runMultiTouchesTestLayer()
-- local scene=runGameWinLayer(true)
-- CCDirector:sharedDirector():replaceScene(_s)
-- local scene =runtan_fumu3Layer()
-- local scene =runtan_fumu2Layer()
-- local scene =runtan_fumu1Layer()
-- local scene =runtan_babyLayer()
-- local scene =runGMTJLayer()
-- local scene =runRichLayer()
-- local scene =runGame1Layer()
local scene =runLogoLayer()
-- local scene=rungame2WinLayer()
-- local scene =runGame2Layer()
-- local scene =runTest()
-- cclog("--------------------")
-- local scene =runMvLayer()
CCDirector:sharedDirector():runWithScene(scene)