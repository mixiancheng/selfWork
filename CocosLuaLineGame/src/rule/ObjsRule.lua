---
--规则
--mxc
module("ObjsRule",package.seeall)-->规则模块
local allObjs={}-->所有物体
local pushObjs=nil-->已经入队列物体
local rowNum={}
function SupplementObj(col,num) --@return typeOrObject
    cclog("num=====>%d",num)
    local row=Config.MapRow-1+num
    math.randomseed(os.time()*col*num)
    local _type=math.random(1,4)
    local obj=mapLayer:creatObj(_type,col,row)
    changeMovePoint(obj,0,-num)
end
---
--
--获得某列顶点
function findUpPoint(_col) --@return typeOrObject
    local tempTable={}
    for k,v in ipairs(allObjs) do
        local col=v.moveCol
        if col==_col then
            table.insert(tempTable,v)
        end
    end
    if #tempTable==0 then return -1 end
    function comps(_objA,_objB)
        return _objA.moveRow < _objB.moveRow
    end
    table.sort(tempTable,comps)
    local UpObjs=tempTable[#tempTable]
    local upRow=UpObjs.moveRow
    return upRow
end
---
--
--自由落体寻找目标点
function findMovePoint(_obj) --@return typeOrObject
    local upRow=findUpPoint(_obj.moveCol)
    local curRow=_obj.moveRow
    if upRow<curRow then
        _obj.moveRow=upRow---设定移动row
    end

end
---
--
--obj工厂
function objfactory() --@return typeOrObject2014082-2014085
    for var=0, Config.MapCol-1 do
        local PointRow=findUpPoint(var)
        local num=0
        while PointRow<Config.MapRow-1 do
            cclog("col=====>%d",var)---需要填充
            local row=PointRow+1
            math.randomseed(os.time()*var-num*os.time())
            local _type=math.random(1,4)
            local obj=mapLayer:creatObj(_type,var,Config.MapRow+num)
            obj.moveRow=row
            obj.moveCol=var
            cclog("moveRow====%d",row)
            num=num+1
            PointRow=findUpPoint(var)
        end
end
end
---
--
--修改movepoint
function changeMovePoint(_obj,_colStep,_rowStep) --@return typeOrObject
    _obj.moveCol=_obj.moveCol+_colStep
    _obj.moveRow=_obj.moveRow+_rowStep
end
---
--
--填充单元
function fillCell(_col,_row) --@return typeOrObject
    if rowNum[_col]==nil then rowNum[_col]=0 end
    rowNum[_col]=rowNum[_col]+1
    local col=_col
    local row=Config.MapRow+rowNum[_col]
    local _moveCol=col
    local _moveRow=_row
    for i=_row, limit do

    end
end
---
--
--填充规则
function fillRule(parameters) --@return typeOrObject
    for _row=0, Config.MapRow do
        for _col=0, Config.MapCol do
            local _obj=getObjByMovePoint(_col,_row)
            if _obj==nil then-->单元nil需要填充（不为nil不需要处理）
                fillCell(_col,_row)
            end
        end
end
end
---
--
--单元掉落
function dropObjs(col,row) --@return typeOrObject
    for _row=row, Config.MapRow-1 do
        local _obj=getObjByCR(col,_row)
        if _obj~=nil then-->单元nil需要填充（不为nil不需要处理）
            changeMovePoint(_obj,0,-1)
        end
end
end
---
--
--掉落规则
function dropRule() --@return typeOrObject
    local _num=0
    for _row=0, Config.MapRow-1 do
        for _col=0, Config.MapCol-1 do
            local _obj=getObjByCR(_col,_row)
            if _obj==nil then-->单元nil需要填充（为nil不需要处理)
                _num=_num+1
                dropObjs(_col,_row)
                --                SupplementObj(_col,_num)
            end
        end
    end
end
---
--
--获得物体根据行列(Col,Row)
function getObjByCR(_col,_row) --@return typeOrObject
    for k,v in ipairs(allObjs) do
        if _col==v.Col and _row==v.Row then return v end
end
return nil
end
---
--
--获得物体根据行列(moveCol,moveRow)
function getObjByMovePoint(_col,_row) --@return typeOrObject
    for k,v in ipairs(allObjs) do
        if _col==v.moveCol and _row==v.moveRow then return v end
end
return nil
end
---
--
--x y 获得物体
---
function getObjByPoint(x,y) --@return typeOrObject
    for k,v in ipairs(allObjs) do
        if v:containsTouchLocation(x,y) then return v end
end
cclog("find false---->")
return nil
end
--
--获得全部物体
function getAllObjs() --@return typeOrObject
    return allObjs
end
---
--
--添加物体
function addObj(_obj) --@return typeOrObject
    table.insert(allObjs,_obj)
end
---
--
--清楚物体
function clearAllObjs() --@return typeOrObject
    allObjs=nil
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
--获得objs索引
function getIndexInTable(_table,_obj) --@return typeOrObject
    for k,v in ipairs(_table) do
        if v:isSame(_obj) then return k end
end
return -1
end
---
--
--爆破一个单元
function bomb(_obj) --@return typeOrObject
    local _index=getIndexInTable(allObjs,_obj)
    local _temp=table.remove(allObjs,_index)
    _temp:Bomb()
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
        pushObjs=nil-->清除队列
        return
    end
    for k,v in ipairs(_objs) do
        bomb(v)
    end
    pushObjs=nil-->清除队列
end
---
--
--是否已经存在于删除队列
function checkPushList(_obj) --@return typeOrObject
    for k,v in ipairs(pushObjs) do
        if (v:isSame(_obj)==true) then return true end
end
return false
end
---
--
--添加删除队列
function PushList(_obj) --@return typeOrObject
    if pushObjs==nil or #pushObjs<1 then
        pushObjs={}
        table.insert(pushObjs,_obj)
        _obj:setSelect(true)-->debug
        return
end
if _obj.Type~=pushObjs[#pushObjs].Type then return end -->类型不同

if checkPushList(_obj)==true then-->已经存在于队列
    --    cclog("----->")
    local _last=pushObjs[#pushObjs]
    if _last:isSamePosition(_obj) then return end -->处于队尾
    local _index=getIndexInTable(pushObjs,_obj)-->位置索引
    while _index~=#pushObjs do
        pushObjs[#pushObjs]:setSelect(false)-->debug
        table.remove(pushObjs,#pushObjs)
    end
    return
end
-------------------不属于队列--------------------------
local _last=pushObjs[#pushObjs]
local _bool=isAdjoin(_last,_obj)
if _bool then
    table.insert(pushObjs,_obj)
    _obj:setSelect(true)-->debug
end -->与队尾相邻
end
---
--
--处理触摸事件
function MyTouch(_touch) --@return typeOrObject
    local  x=_touch:getLocation().x
    local  y=_touch:getLocation().y
    --    cclog("xx==%d,yy==%d",x,y)
    local _obj=getObjByPoint(x,y)--触摸物体
    if _obj==nil then return true end
    --    cclog("col==%d,row==%d",_obj.Col,_obj.Row)
    PushList(_obj)-->添加删除队列
end
function dropAction() --@return typeOrObject
    for k,v in ipairs(allObjs) do
        v:MoveToPoint()
end
end
---
--
--添加队列完成
function OnTouchEnd(touch) --@return typeOrObject
    bombObjs(pushObjs)
    dropRule()
    dropAction()
    objfactory()
    dropAction()
end
