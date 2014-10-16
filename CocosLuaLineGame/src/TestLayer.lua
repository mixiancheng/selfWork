TestLayer=class("TestLayer",function () --@return typeOrObject
	return cc.Layer:create()
end)
TestLayer.__index=TestLayer
function creatTestLayer() --@return typeOrObject
	local _temp=TestLayer.new()
	require "Obj"
	local _spri=creatObj(1,5,5);
	_temp:addChild(_spri)
	
	require "MapCellNode"
	local _mapCel=creatMapCellNode(0,5,5)
    _temp:addChild(_mapCel)
    return _temp
end
function creatTestSceen() --@return typeOrObject
    local _scene=cc.Scene:create()
    _scene:addChild(creatTestLayer())
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(_scene)
    else
        cc.Director:getInstance():runWithScene(_scene)
    end
end