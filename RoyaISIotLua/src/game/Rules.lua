module("Rules",package.seeall)
_DATE_TYPE= {
    WILD={type=12,name="item_12.png"},
    SPEC={type=1,name="item_1_1.png"},
    Item1={type=2,name="item2.png"},
    Item2={type=3,name="item3.png"},
    Item3={type=4,name="item4.png"},
    Item4={type=5,name="item5.png"},
    Item5={type=6,name="item6.png"},
    Item6={type=7,name="item7.png"},
    Item7={type=8,name="item8.png"},
    Item8={type=9,name="item9.png"},
    Item9={type=10,name="item10.png"},
    Item10={type=11,name="item11.png"},
    FREE={type=13,name="item_13_1.png"},
    JACKPOT={type=14,name="item_14.png"}}
--根据类型获得图片名字
function get_img_Name(_type)
    for k,v in pairs(_DATE_TYPE) do
        if v.type==_type then
            return v.name
        end
    end
    cclog("type".._type)
    return nil
end
moveTimes=1*60
moveStep=30
colNum=5
rowNum=4
cellW=110
cellH=110
Lines={
--{8,6,14,2,10,11,5,4,10,1,11,9,5,3,10,1,6,1,9,8,4,11,7,6,3,8,1,1,8,13,11,2,6,3,5,1,9,13,7,11,4,9,7,1,10,9,2,7,13,11,5,10,10,9,11,11,13,10,1,1,1,1,1},
{1,10,1,10,1,1,1,1,1,1},
    {10,5,13,3,9,12,7,1,10,6,4,10,10,3,13,11,5,9,14,2,10,8,4,12,12,12,7,13,1,11,5,9,11,6,3,8,10,1,9,11,5,13,8,7,2,10,4,11,9,1,13,6,11,3,9,7,10,2,9,8,6,5,9,12,12,1,11,11,4,9,7,10,2,11,8,9,5,11,1,1,9,11,6,12,7,10,3,9,10,1,1,1,1,13,6,4,9,2,10,8,9},
    {10,8,5,9,1,7,6,13,3,10,8,14,4,7,5,12,6,1,10,10,8,11,9,5,10,10,11,7,12,12,12,3,9,9,6,1,8,9,5,7,4,11,11,11,2,13,9,10,6,5,8,1,1,1,1,11,10,7,12,12,2,5,4,9,1,8,10,6,11,3,9,9,10,7,13,1,10,5,8,9,2,10,6,4,13,3,9,11,1,8,7,11,6,5,11,2,9,7,11,6,11},
    {9,5,11,3,1,9,4,10,8,8,12,9,9,8,9,9,1,7,11,5,5,4,12,2,10,10,3,1,10,7,12,6,7,14,2,10,5,7,3,8,1,6,11,6,11,12,12,2,6,1,1,1,4,10,11},
    {8,5,5,2,6,5,6,1,1,12,12,9,2,10,10,4,12,10,9,6,11,11,11,5,8,4,12,7,8,2,10,10,6,11,1,12,8,9,3,9,12,4,7,1,7,3,9,9,1,3,7,14
    }}
HitLines={"11111","32123","01210","21012","12321","32323","01010","23232","10101","21212","12121"};
--*获得指定线的指定列
--_col(0~N)
function getLine(_lineNum, _col)
--cclog("_lineNum".._lineNum.."col".._col)
    _col=_col+1
    local _lineData={string.byte(HitLines[_lineNum],1,-1)}
    return string.char((_lineData[_col]))
end
--获得线连接点
function getLineDrawPoint(_index)
--cclog("_index".._index)
    local _table={}
    for var=0, 4 do
        local _point={}
        _point._row=getLine(_index,var)
        _point._col=var
        table.insert(_table,_point)
    end
    return _table
end
--获得齿轮数据
function getLine_Value( _line_Index,_index)
    local _table=Lines[_line_Index]
    local len=#_table
    _index=(_index%len)+1
--    if _line_Index==1 then
--    	return _DATE_TYPE.SPEC.type
--    end
--    if _index==1 then
--        return _DATE_TYPE.SPEC.type
--    end
    return _table[_index]
end
--获得元素
--_col(0~N)
--_row(0~N)
function getObjByCR(_col,_row)
    local _colNodes=_GameControl._colNodes[_col+1]
    local _obj=_colNodes._objs[_row+1]
    return _obj
end
--是否出发RSpin
function checkRspin()
    local _first=_GameControl._colNodes[1]._objs
    local _Rspin=true
    for var=1, rowNum do
        local v=_first[var]
        if v._type~=_DATE_TYPE.SPEC.type then
            _Rspin=false
        end
    end
    return _Rspin
end
function checkLins(_index)
    local lineTable=getLineDrawPoint(_index)
    local _type=-1
    local _table={}
    for k,v in ipairs(lineTable) do
        local _col=v._col
        local _row=v._row
        local _obj=getObjByCR(_col,_row)
        if _type==-1 or _type==_obj._type or _obj._type==_DATE_TYPE.WILD.type then
            _type=_obj._type
            local _temp={}
            _temp._obj=_obj
            _temp._col=_col
            _temp._row=_row
            table.insert(_table,_temp)
        else
        break
        end
    end
    if #_table>=3 then
        local _final={}--{_index,_array={{_obj,_col,_row}.....}}
        _final._index=_index
        _final._array=_table
        return _final
    end
    return nil
end
--获得命中线
function getHitLines()
local _len=#HitLines
--cclog("_len===".._len)
    local _final=nil
    for var=1, _len do
        local _array=checkLins(var)
        if _array~=nil then
            if _final==nil then
                _final={}
            end
            table.insert(_final,_array)
        end
    end
    return _final
end
