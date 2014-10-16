GameLayer=class("GameLayer",function()
	return cc.Layer:create()
end)
GameLayer.__index=GameLayer
GameLayer._colNodes={}
function GameLayer:initColNodes()
    require "GameColNode"
    for _col=0, _rule.colNum-1 do
        local _colNode= CreatColNode(_col)
        self:addChild(_colNode)
        table.insert(_GameControl._colNodes,_colNode)
    end
--    local _obj=_rule.getObjByCR(0,0)
--    cclog("_type".._obj._type)
--cclog("*****************************************")
--    for var=_rule.rowNum-1,0,-1 do
--        cclog(_rule.getObjByCR(0,var)._type..","
--            .._rule.getObjByCR(1,var)._type..","
--            .._rule.getObjByCR(2,var)._type..","
--            .._rule.getObjByCR(3,var)._type..","
--            .._rule.getObjByCR(4,var)._type
--        )
--    end
--cclog("_________________________________________")
--    local glNode  = gl.glNodeCreate()
--        local function primitivesDraw(transform, transformUpdated)
--            kmGLPushMatrix()
--            kmGLLoadMatrix(transform)
--    local yellowPoints = { cc.p(0,0), cc.p(50,50), cc.p(100,0), cc.p(150,50)}
--    cc.DrawPrimitives.drawPoly( yellowPoints, 4, false)
--        kmGLPopMatrix()
--    end
--    glNode:registerScriptDrawHandler(primitivesDraw)
--    self:addChild(glNode)
end
function CreatGameLayer()
	local _layer=GameLayer.new()
	_layer:initColNodes()
	require "GameLineLayer"
	_lineLayer=CreatGameLineLayer()
	_layer:addChild(_lineLayer)
	return _layer
end
function testGameLayer()
    local _scene = cc.Scene:create()
    local layer = CreatGameLayer()
    _scene:addChild(layer)
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(_scene)
    else
        cc.Director:getInstance():runWithScene(_scene)
    end
end