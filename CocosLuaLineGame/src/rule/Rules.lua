_mapCellType={normal="normal",dead="dead",factory="factory",lock="lock"}--地图块类型
--规则
module("Rules",package.seeall)
require "Obj"
_mapData={}--obj,_type,_row,_col
MapCol=5
MapRow=8
objW=72
objH=72
MapPositonX=0
MapPositonY=0
touchPoint=nil
touchObjs={obj1=nil,obj2=nil}
debug_color={normal=cc.c4f(140/255,141/255,105/255,0.2),
    dead=cc.c4f(125/255,98/255,10/255,1),
    factory=cc.c4f(6/255,236/255,28/255,0.1),
    lock=cc.c4f(10/255,20/255,161/255,1)
}
local _mapCells={}--所有地图集合
local _pushObjs={}--已选中队列
_mapLayer=nil--地图
_node=nil--可视窗口

---
--
--获得_mapData数据
function get_mapData_cell(_row,_col) --@return typeOrObject
--    for k,v in ipairs(_mapData) do 
--        if v._col==_col and v._row==_row then
--            return v
--        end
--    end
if _mapData[_row]==nil then
	return nil
end
return _mapData[_row][_col]
end
--根据坐标获得cell数据
function get_mapData_cell_bycr(_row,_col) --@return typeOrObject
    local col,_a=math.modf(_col/objW)
    local row,_b=math.modf(_row/objH)
    local cell=get_mapData_cell(row,col)
    return cell
end
---
--
--是否可通过单元
function isAliveCel(_temp) --@return typeOrObject
    if _temp~=nil and _temp.obj==nil then
        if _temp._type~="dead" and _temp._type~="lock" then
            return true
        end
end
return false
end
---
--
--是否死节点
function isDeadCel(_row,_col) --@return typeOrObject
    local _temp=get_mapData_cell(_row,_col)
    if _temp==nil then
        return true
    end
    if _temp._type=="dead"or _temp._type=="lock" then
        return true
    end
    return false
end
local _paths={}
function findPath(_row,_col) --@return typeOrObject
    local _center=get_mapData_cell(_row,_col)
    local _left=get_mapData_cell(_row,_col-1)
    local _right=get_mapData_cell(_row,_col+1)
    local _point=nil
    if isAliveCel(_center) then--深度
        --            cclog("findCenter")
        _point=cc.p(_row,_col)
        return _point
            --        findPath(_row-1,_col)
            --        table.insert(_paths,_point)
    end
    if isDeadCel(_row+1,_col-1) and isAliveCel(_left) then --左子点
        cclog("findLeft")
        _point=cc.p(_row,_col-1)
        return _point
            --        findPath(_row-1,_col-1)
            --        table.insert(_paths,_point)
    end
    if isDeadCel(_row+1,_col+1) and isAliveCel(_right) then --右子点
        cclog("findRight")
        _point=cc.p(_row,_col+1)
        return _point
            --        findPath(_row-1,_col+1)
            --        table.insert(_paths,_point)
    end
    return nil
end
function find(_obj) --@return typeOrObject
end
---
--
--爆破一个单元
function bomb(_obj) --@return typeOrObject
    local v=get_mapData_cell(_obj._row,_obj._col)
    v.obj=nil
    _obj:Bomb()
    if v._type==_mapCellType.lock then
        v._type=_mapCellType.normal
        --    _obj:setLock(false)
    end
end
---
--
--爆炸队列
function bombObjs(_objs) --@return typeOrObject
    if _objs==nil then return end
    if #_objs<3 then
        for k,v in ipairs(_objs) do
            v:setSelect(false)
        end
        _pushObjs=nil-->清除队列
        return
    end
    for k,v in ipairs(_objs) do
        bomb(v)
    end
    _pushObjs=nil-->清除队列
end
---
--
--获得objs索引
function getIndexInTable(_table,_obj) --@return typeOrObject
    for k,v in ipairs(_table) do
        if v:isEqual(_obj) then return k end
end
return -1
end
---
--
--判断是否相邻
function isAdjoin(_obj1,_obj2) --@return typeOrObject
    local _pa=_obj1:getMapPoint()
    local _pb=_obj2:getMapPoint()
    local _len=cc.pGetDistance(_pa,_pb)
    --    cclog("len=====%d",_len)
    if _len<=1.5 then
        --    cclog("------------>")
        return true
    end
    return false
end

---
--
--x y 获得物体
---
function getObjByPoint(x,y) --@return typeOrObject
    for k,v in ipairs(_mapData) do
        if v.obj~=nil then
            if v.obj:containsTouchLocation(x,y) then
                return v.obj end
        end
end
end
---
--
--是否已经存在于删除队列
function checkPushList(_obj) --@return typeOrObject
    for k,v in ipairs(_pushObjs) do
        if (v:isEqual(_obj)==true) then return true end
end
return false
end
---
--
--添加删除队列
function PushList(_obj) --@return typeOrObject
    if _pushObjs==nil or #_pushObjs<1 then
        _pushObjs={}
        table.insert(_pushObjs,_obj)
        _obj:setSelect(true)-->debug
        return
end
if _obj._type~=_pushObjs[#_pushObjs]._type then return end -->类型不同
if checkPushList(_obj)==true then-->已经存在于队列
    --    cclog("----->")
    local _last=_pushObjs[#_pushObjs]
    if _last:isEqual(_obj) then return end -->处于队尾
    local _index=getIndexInTable(_pushObjs,_obj)-->位置索引
    while _index~=#_pushObjs do
        _pushObjs[#_pushObjs]:setSelect(false)-->debug
        table.remove(_pushObjs,#_pushObjs)
    end
    return
end
-------------------不属于队列--------------------------
local _last=_pushObjs[#_pushObjs]
local _bool=isAdjoin(_last,_obj)
if _bool then
    table.insert(_pushObjs,_obj)
    _obj:setSelect(true)-->debug
end -->与队尾相邻
end
---
--
--处理触摸事件
function MyTouch(_touch) --@return typeOrObject
    if isMoveOver()~=true then
        return end
local  x=_touch:getLocation().x
local  y=_touch:getLocation().y
--        cclog("-->xx==%d,yy==%d",x,y)
local _obj=getObjByPoint(x,y)--触摸物体
if _obj==nil then return true end
PushList(_obj)-->添加删除队列
end
function dropAction() --@return typeOrObject

end
function moveObj(_obj) --@return typeOrObject
    if _obj:isNormal() then
        local _col=_obj._col
        local _row=_obj._row
        local  newPoint=findPath(_row-1,_col)
        if newPoint~=nil then
            local oldCel=get_mapData_cell(_row,_col)
            local newCel=get_mapData_cell(newPoint.x,newPoint.y)
            newCel.obj=_obj
            oldCel.obj=nil
            --        cclog("------>")
            _obj:MovePoint(newPoint.x,newPoint.y)
        end
end
end
function isMoveOver() --@return typeOrObject
    for k,v in ipairs(_mapData) do
        if v.obj~=nil then
            if v.obj._state==ObjState.droping then
                return false end
        end
end
return true
end
function isInTable(_table,_cell) --@return typeOrObject
	for k,v in ipairs(_table) do
		if v._col==_cell._col and v._row==_cell._row then 
		return true
		end 
	end
	return false
end
function checkDellList(_cell,_table) --@return typeOrObject
if _cell==nil
or _cell._type==_mapCellType.factory
or _cell.obj==nil 
then return
        end

local _col=_cell._col
local _row=_cell._row
    local cellDate_right=get_mapData_cell(_row,_col+1)
    local cellDate_down=get_mapData_cell(_row-1,_col)
    local cellDate_left=get_mapData_cell(_row,_col-1)
    local cellDate_up=get_mapData_cell(_row+1,_col)
    if cellDate_right~=nil
    and isInTable(_table,cellDate_right)~=true
    and cellDate_right.obj~=nil
    and cellDate_right._type~=_mapCellType.factory
    and cellDate_right.obj._type==_cell.obj._type
    then
        table.insert(_table,cellDate_right)
        checkDellList(cellDate_right,_table)
    end
    if cellDate_down~=nil
    and isInTable(_table,cellDate_down)~=true
    and cellDate_down._type~=_mapCellType.factory
    and cellDate_down.obj~=nil
    and cellDate_down.obj._type==_cell.obj._type
    then
        table.insert(_table,cellDate_down)
        checkDellList(cellDate_down,_table)
    end
    if cellDate_left~=nil
    and isInTable(_table,cellDate_left)~=true
    and cellDate_left._type~=_mapCellType.factory
    and cellDate_left.obj~=nil
    and cellDate_left.obj._type==_cell.obj._type
    then
    table.insert(_table,cellDate_left)
    checkDellList(cellDate_left,_table)
    end
    if cellDate_up~=nil
    and isInTable(_table,cellDate_up)~=true
    and cellDate_up._type~=_mapCellType.factory
    and cellDate_up.obj~=nil
    and cellDate_up.obj._type==_cell.obj._type
    then
        table.insert(_table,cellDate_up)
        checkDellList(cellDate_up,_table)
    end
end
function changeCell(_cell,_dir) --@return typeOrObject
--if _cell._type==_mapCellType.factory then return end 
cclog("------------------>")
    if _cell==nil then return end
    if _cell.obj==nil then return end
    local _point=cc.p(_cell._col,_cell._row)
    _point=cc.pAdd(_point,_dir.point)
    local _cellturn=get_mapData_cell(_point.y,_point.x)
    if _cellturn==nil then return end
    if _cellturn.obj==nil then return end
    local _obj=_cell.obj
    local _tempObj=_cellturn.obj
    local Move1=cc.p(_tempObj:getPositionX(),_tempObj:getPositionY())
    local Move2=cc.p(_obj:getPositionX(),_obj:getPositionY())
    local _action1=cc.MoveTo:create(0.25,Move1)
    local _action2=cc.MoveTo:create(0.25,Move2)
    local function moveOver(sender)
       cclog("moveOver")
        _cell.obj=_tempObj
        _cell.obj._col=_cell._col
        _cell.obj._row=_cell._row
        _cellturn.obj=_obj
        _cellturn.obj._col=_cellturn.obj._col
        _cellturn.obj._row=_cellturn.obj
        local _table={}
        table.insert(_table,_cell)
        checkDellList(_cell,_table)
        if #_table<3 then
        	_table={}
        end
        local _tableTurn={}
        table.insert(_tableTurn,_cellturn)
        checkDellList(_cellturn,_tableTurn)
        if #_tableTurn<3 then
        	_tableTurn={}
        end
        for i,j in ipairs(_tableTurn) do
            local b=j.obj
            if b~=nil then
                BombCell(j)
            end
        end
        for k,v in ipairs(_table) do
        	local b=v.obj
        	if b~=nil then 
            BombCell(v)
            end
        end
        setGameState(GAMESTATE.bombing)
    end
    local action = cc.Sequence:create(_action2,cc.CallFunc:create(moveOver))
    _obj:runAction(_action1)
    _tempObj:runAction(action)
end
---
--
--添加队列完成
function OnTouchEnd(touch) --@return typeOrObject
end
function OnTouchMove(touch) --@return typeOrObject
if touchPoint==nil then return end
if getGameState()~=GAMESTATE.normal then return end
local _endPoint=touch:getLocation()
local _endX=_endPoint.x
local _endY=_endPoint.y
if _endX>touchPoint.x and _endX-touchPoint.x>50 then--right
    changeCell(touchObjs._cell1,DIR.right)
    touchPoint=nil
    return
end
if _endX<touchPoint.x and touchPoint.x-_endX<50 then--left
    changeCell(touchObjs._cell1,DIR.left)
    touchPoint=nil
    return
end
if _endY>touchPoint.y and _endY-touchPoint.y>50 then--up
    changeCell(touchObjs._cell1,DIR.up)
    touchPoint=nil
    return
end
if _endY<touchPoint.y and touchPoint.y-_endY<50 then--down
    changeCell(touchObjs._cell1,DIR.down)
    touchPoint=nil
    return
end
end
function OnTouchBegin(_touch) --@return typeOrObject
    if getGameState()~=GAMESTATE.normal then return end
    touchPoint=_touch:getLocation()
    touchObjs._cell1=get_mapData_cell_bycr(touchPoint.y,touchPoint.x)
end