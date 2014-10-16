function TestPb_rep()
    cclog("TestPb_rep-->")
    local person_pb=require("person_pb")
    local person=person_pb.Person()
    person.id=1001
    person.name="name"
    person.email="email"
    local _data=person.data
    table.insert(_data,"testPb1.lua")
    table.insert(_data,"testPb2.lua")
    table.insert(_data,"testPb3.lua")
    cclog("------>")
    print("person---\n"..text_format.msg_format(person))
end
