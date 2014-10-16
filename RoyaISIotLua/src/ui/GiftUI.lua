local GiftUI = class("GiftUI",function()
    return cc.LayerColor:create(cc.c4b(0,0,0,128))
end)

local kConfigFile = "Gift_UI.json"

function GiftUI:ctor()

end

function GiftUI:init()
    
end

function GiftUI:create()
    local messageUi = GiftUI:new()
    messageUi.rootNode = tgGuiReader:widgetFromJsonFile(kConfigFile)
    messageUi:addChild(messageUi.rootNode)
    messageUi:init()
    return messageUi
end

function createGiftUI()
    return GiftUI:create()
end
