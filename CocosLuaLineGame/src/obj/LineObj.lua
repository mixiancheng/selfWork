LineObj=class(LineObj,function() --@return typeOrObject
    return cc.Node:create()
end)
LineObj.__index=LineObj
LineObj.Type=nil
LineObj.Row=nil
LineObj.Col=nil
LineObj.moveRow=nil-->目标行
LineObj.moveCol=nil-->目标列
LineObj.width=nil
LineObj.height=nil
LineObj.avt=nil
LineObj.LockNums=1
LineObj.LockNumsAvt=nil
LintObjType={"one","two","three","four"}
function LineObj:isSame(_obj) --@return typeOrObject
    if (self:isSamePosition(_obj) and self.Type==_obj.Type) then return true end 
    return false
end
---
--是否相同
--
function LineObj:isSamePosition(_obj) --@return typeOrObject
    if self.Col==_obj.Col and self.Row==_obj.Row then return true end 
    return false
end
function LineObj:setSelect(_boo) --@return typeOrObject
	if _boo then self.avt:setScale(0.5,0.5) return end 
    self.avt:setScale(0.8,0.8)
end
---
--爆炸
--
function LineObj:Bomb() --@return typeOrObject
	self:setVisible(false)
	self:removeFromParent(true)-->删除形象
end
---
--获得地图行列
function LineObj:getMapPoint() --@return typeOrObject
	return cc.p(self.Col,self.Row)
end
---
--
--设置目标行列
function LineObj:setMovePoint(_row,_col) --@return typeOrObject
	self.moveRow=_row
	self.moveCol=_col
end
---
--
--move
function LineObj:MoveToPoint() --@return typeOrObject
if self.Row==self.moveRow and self.Col==self.moveCol then return end 
    local x=self.moveCol*Config.objW
    local y=self.moveRow*Config.objH
    self.Row=self.moveRow
    self.Col=self.moveCol
    local MoveAction=cc.MoveTo:create(0.2,cc.p(x,y))
    local function moveOver(node)
    end
    self:runAction( cc.Sequence:create(MoveAction,cc.CallFunc:create(moveOver)))
end
function LineObj:InitLineObj(_type,_col,_row) --@return typeOrObject
    require "Config"
    self.width=Config.objW
    self.height=Config.objH
    self:setContentSize(self.width,self.height)
    self.Type=_type
    self.Row=_row
    self.Col=_col
    self.moveRow=_row
    self.moveCol=_col
    local str=string.format("%s.png",_type)
    self.avt=cc.Sprite:create(str)
    self:addChild(self.avt)
    self.avt:setScale(0.8,0.8)
    self.avt:setPosition((self.width)/2,(self.height)/2)
    self.avt:setAnchorPoint(0.5,0.5)
    LockNumsAvt= cc.LabelTTF:create("11111"..self.LockNums, "Arial", 24)
    cclog("----------->")
    self:addChild(LockNumsAvt)
end
function LineObjCreat(_type,_col,_row) --@return typeOrObject
    local _temp=LineObj.new()
    _temp:registerScriptHandler(function(tag)
    if "enter" == tag then
        _temp:onEnter()
    elseif "exit" == tag then
    end
    end)
    _temp:InitLineObj(_type,_col,_row)
    require "ObjsRule"
    ObjsRule.addObj(_temp)
    return _temp
end
function LineObj:containsTouchLocation(x,y) --@return typeOrObject
    local position = cc.p(self:getPosition())
    local  s = self:getContentSize()
    local touchRect = cc.rect(Config.MapPositonX+position.x, Config.MapPositonY+position.y, s.width-20, s.height-20)
    local b = cc.rectContainsPoint(touchRect, cc.p(x,y))
    return b
end
function LineObj:onEnter()
end