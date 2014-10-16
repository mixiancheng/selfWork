GameObjNode=class("GameObjNode",function()
	return cc.Node:create()
end)
GameObjNode.__index=GameObjNode
GameObjNode._col=0--列
GameObjNode._row=0--行
GameObjNode._type=0--类型
GameObjNode._isLock=false--是否锁定
GameObjNode._avt=nil--形象
GameObjNode._isFinaldata=false
GameObjNode._debug=nil
function GameObjNode:initData(_type,_col,_row)
	self._isFinaldata=false
	self._isLock=false
	self:setCRPoint(_col,_row)
    self:setType(_type)
end
function GameObjNode:updateText(dt)
    self._debug:setString(self._col..","..self._row.."|"..self._type)
end
--设置行列坐标
function GameObjNode:setCRPoint(_col,_row)
    self._col=_col
    self._row=_row
--    self:setPositionX(_col*_rule.cellW)
    self:setPositionY(_row*_rule.cellH)
    schedule(self,self.updateText,0.2)
end
--设置类型初始化形象
function GameObjNode:setType(_type)
    self._type=_type
    local name=_rule.get_img_Name(_type)
--    cclog(""..name)
    self._avt=cc.Sprite:createWithSpriteFrameName(name)
    self._avt:setPosition(cc.p(0,0))
    self._avt:setAnchorPoint(cc.p(0,0))
    self:addChild(self._avt)
    self._debug=cc.LabelTTF:create(""..self._type,"Arial", 50)
    self._debug:setAnchorPoint(0.5,0.5)
    self._debug:setPosition(_rule.cellW/2,_rule.cellH/2)
    self._debug:setColor(cc.c3b(246, 242,6))
    self._debug:setScale(0.5)
    self._debug:setVisible(false)
    self:addChild(self._debug)
end
--创建元素
function creatGameObjNode(_type,_col,_row)
	local _objNode=GameObjNode.new()
    _objNode:initData(_type,_col,_row)
	return _objNode
end
