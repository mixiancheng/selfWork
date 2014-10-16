_main = require("main_pb")
function testPb() --@return typeOrObject
    local _res=_main.LoginResponse()
    _res.fid=""
    _res.uid=11
    _res.token="token"
    _res.ret=0
    print("***\n"..text_format.msg_format(_res)) 
    local _str=_res:SerializeToString()
    cclog("%s",_str)
    local _newRes=_main.LoginResponse()
    _newRes:ParseFromString(_str)
    print("---\n"..text_format.msg_format(_newRes))
end