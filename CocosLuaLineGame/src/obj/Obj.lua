require "Config"
Obj=class("Obj",function () --@return typeOrObject
    return cc.Node:create()
end)
Obj.__index=Obj
Obj._col=0--列
Obj._row=0--行
Obj._type=0--类型
Obj._avt=nil--形象
Obj._select=false--是否被选中
Obj._paths={}
Obj._state=-1
Obj._isfactory=false
Obj._liveNum=0--销毁次数
Obj.LiveNumsAvt=nil
Obj._isLock=false
Obj.LockAvt=nil
Obj._delDir=-1--方向
Obj.delDirAvt=nil--方向形象
DelDir={Normal=-1,Cross=0,Vertical=1,Double=3}
Obj._allSameDel=false
Obj._allSameDelAvt=nil
Obj._schedulerId=0
ObjState={normal=0,droping=1,dead=-3}
ObjType={"one","two","three","four"}
function Obj:moveTopoint(_x,_y) --@return typeOrObject
    self._state=ObjState.droping
	local function moveOver() --@return typeOrObject
    self._state=ObjState.normal
	end
	local _moveAction=cc.MoveTo:create(0.1,cc.p(_x,_y))
	local _action=cc.Sequence:create(_moveAction,cc.CallFunc:create(moveOver))
	self:runAction(_action)
end
function Obj:draw() --@return typeOrObject
	cclog("draw------------------->")
end
function Obj:isNormal() --@return typeOrObject
    if self._state==ObjState.normal then
        return true
end
return false
end
function Obj:movePath(debugPath) --@return typeOrObject
    for k,v in ipairs(debugPath) do
        local _col=v.x
        local _row=v.y
        --		cclog("path_col==%d,row==%d",_col,_row)
        local _x=_col*Rules.objW
        local _y=_row*Rules.objH
        self:setPosition(_x,_y)
end
end
function Obj:MovePoint(_row,_col) --@return typeOrObject
    function moveOver(sender) --@return typeOrObject
        self._col=_col
        self._row=_row
        local  newPoint=Rules.findPath(self._row-1,self._col)
        if newPoint==nil then self._state=ObjState.normal else
            local oldCel=Rules.get_mapData_cell(self._row,self._col)
            local newCel=Rules.get_mapData_cell(newPoint.x,newPoint.y)
            newCel.obj=self
            oldCel.obj=nil
            self:MovePoint(newPoint.x,newPoint.y)
        end
    end
    local _x=_col*Rules.objW
    local _y=_row*Rules.objH
    self._state=ObjState.droping
    --	self._col=_col
    --	self._row=_row
    local _moveAction=cc.MoveTo:create(0.025,cc.p(_x,_y))
    local _action = cc.Sequence:create(_moveAction,cc.CallFunc:create(moveOver))
    self:runAction(_action)
    --    self._state=ObjState.normal
end
---
--爆炸
--
function Obj:Bomb() --@return typeOrObject
    local scheduler =cc.Director:getInstance():getScheduler()
    scheduler:unscheduleScriptEntry(self._schedulerId)
    self._state=ObjState.dead
    self:setVisible(false)
    self:removeFromParent(true)-->删除形象
end
function Obj:getMapPoint() --@return typeOrObject
    return cc.p(self._col,self._row)
end
function Obj:isEqual(_obj) --@return typeOrObject
    if self._col==_obj._col and self._row==_obj._row and self._type==_obj._type then return true end
    return false
end
function Obj:setSelect(var) --@return typeOrObject
    --cclog("----------->")
    if var then self._avt:setScale(0.5,0.5) return end
    self._avt:setScale(0.8,0.8)
    self._select=var
end
function Obj:containsTouchLocation(x,y) --@return typeOrObject
    local position = cc.p(self:getPosition())
    local  s = self:getContentSize()
    --    cclog("x==%d,y==%d",x,y)
    --    cclog("x==%d,y==%d,w===%d,h===%d",position.x,position.y,s.width,s.height)
    local touchRect = cc.rect(position.x+10, position.y+10, s.width-10, s.height-10)
    local b = cc.rectContainsPoint(touchRect, cc.p(x,y))
    --    if b==true then cclog("--------->contain") end
    return b
end
function Obj:addLockNode() --@return typeOrObject
if self.LockAvt==nil then
    self.LockAvt=cc.DrawNode:create()
    local star1 = { cc.p( 0, 0), cc.p(0, 0+Rules.objH), cc.p(0+Rules.objW, 0+Rules.objH), cc.p(0+Rules.objW, 0),
        cc.p( 0, 0),cc.p(0+Rules.objW, 0+Rules.objH),cc.p(0+Rules.objW, 0),cc.p(0, 0+Rules.objH)

    }

        self.LockAvt:drawPolygon(star1, table.getn(star1), cc.c4f(1,0,0,0), 1, cc.c4f(0.5,0,1,1))
    self:addChild(self.LockAvt)
    end
end
function Obj:addLiveNumber() --@return typeOrObject
    self.LiveNumsAvt= cc.LabelTTF:create(""..self._liveNum, "Arial", 24)
    self:addChild(self.LiveNumsAvt)
    self.LiveNumsAvt:setColor(cc.c3b(255,100,0))
    self.LiveNumsAvt:setPosition(Rules.objW/2,Rules.objH/2)
end
function Obj:setDelDir(_dirtype) --@return typeOrObject
    if self.delDirAvt==nil then self.delDirAvt= cc.LabelTTF:create("", "Arial", 24)
        self:addChild(self.delDirAvt)
        self.delDirAvt:setColor(cc.c3b(0,200,0))
        self.delDirAvt:setPosition(Rules.objW/2,Rules.objH/2)
end
self._delDir=_dirtype
local str=""
if _dirtype==DelDir.Cross then
    str="<-->"
end
if _dirtype==DelDir.Vertical then str="$" end
if _dirtype==DelDir.Double then
    str="<$>"
end
self.delDirAvt:setString(str)

end
function Obj:addAvt() --@return typeOrObject
    local str=string.format("%s.png",ObjType[self._type])
    self._avt=cc.Sprite:create(str)
    self:addChild(self._avt)
    self._avt:setScale(0.8,0.8)
    self._avt:setAnchorPoint(0.5,0.5)
    self._avt:setPosition(Rules.objW/2,Rules.objH/2)
end
function Obj:setALlSame(_bool) --@return typeOrObject
    self._allSameDel=_bool
    if self._allSameDelAvt==nil then
        self._allSameDelAvt=cc.DrawNode:create()
        self._allSameDelAvt:setPosition(Rules.objW/2,Rules.objH/2)
        self:addChild(self._allSameDelAvt)
        self._allSameDelAvt:drawDot(cc.p(0,0), 10, cc.c4f(0,1,0, 1))
    end
    self._allSameDelAvt:setVisible(_bool)
end
function Obj:setLock(_bool) --@return typeOrObject
	if _bool then
        self:addLockNode()
	else
    self.LockAvt:setVisible(false)
	end
end
---
--
--初始化数据
function Obj:initData(_type,_col,_row) --@return typeOrObject
    self._type=_type
    self._col=_col
    self._row=_row
    self:setContentSize(Rules.objW,Rules.objH)
    local _x=_col*Rules.objW
    local _y=_row*Rules.objH
    self:setPosition(_x,_y)
    self:addAvt()
    self._state=-1
    self._liveNum=1
    self._isLock=false
    self._delDir=DelDir.Normal
    if self._liveNum~=0 then
--        self:addLiveNumber()
    end
--    self:setDelDir(DelDir.Double)
--    self:setALlSame(true)
    ---
    --
    --
    function MyUpdata(parameters) --@return typeOrObject
--        if getGameState()~=GAMESTATE.droping then return end
--        if self._state==ObjState.dead then return end 
--            local _tempcol=self._col
--            local _temprow=self._row-1
--            local  newPoint=Rules.findPath(_temprow,_tempcol)
--            if newPoint~=nil then
--                self._state=ObjState.droping
--                local oldCel=Rules.get_mapData_cell(self._row,self._col)
--                local newCel=Rules.get_mapData_cell(newPoint.x,newPoint.y)
--                newCel.obj=self
--                oldCel.obj=nil
--                self:MovePoint(newPoint.x,newPoint.y)
--            end
--            return
        end
--    local scheduler =cc.Director:getInstance():getScheduler()
--   self._schedulerId= scheduler:scheduleScriptFunc(MyUpdata,0.025, false)
end
---
--
--创建对象
function creatObj(_type,_col,_row) --@return typeOrObject
    local _temp=Obj.new()
    _temp:initData(_type,_col,_row)
    return _temp
end