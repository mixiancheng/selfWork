require("ShortCode")

local kDesignWidth = 1024
local kDesignHeight = 768
local kResolutionPolicy = 0 --0fitxy    1noborder   2showAll   3fity    4fitx

-- global function
tgInitGlobalVar = function()
    tgDirector:getOpenGLView():setDesignResolutionSize(kDesignWidth, kDesignHeight, kResolutionPolicy)
    g_frame_size = tgDirector:getOpenGLView():getFrameSize()
    g_visible_size = tgDirector:getVisibleSize()
    local visibleSize = tgDirector:getVisibleSize()
    local scaleX = visibleSize.width/kDesignWidth
    local scaleY = visibleSize.height/kDesignHeight
    if scaleX>scaleY then
        g_scale_factor = scaleY
    else
        g_scale_factor = scaleX
    end
    cclog("g_frame_size: %f, %f", g_frame_size.width, g_frame_size.height)
    cclog("g_scale_factor: %f", g_scale_factor)
end

tgEnterScene = function (scene)
    scene = cc.TransitionFade:create(0.5,scene)
    if tgDirector:getRunningScene() then
        tgDirector:replaceScene(scene)
    else
        tgDirector:runWithScene(scene)
    end
end

-- link: http://www.cppblog.com/swo2006/articles/16000.html
tgSplitStr = function(str, delimiter)
    assert (type (delimiter) == "string" and string.len (delimiter) > 0,
        "bad delimiter")
    local start = 1
    local t = {}
    while true do
        local pos = string.find (str, delimiter, start, true)
        if not pos then
            break
        end
        table.insert (t, string.sub (str, start, pos - 1))
        start = pos + string.len (delimiter)
    end
    table.insert (t, string.sub (str, start))
    return t
end

tgScreenFix = function(prefix, suffix)
    local finalName = prefix
    local platform = tgApplication:getTargetPlatform()
    if platform == cc.PLATFORM_OS_IPHONE or platform == cc.PLATFORM_OS_IPAD then
        --ios or mac
        finalName = finalName.."_"
        finalName = finalName..g_frame_size.width
        finalName = finalName.."x"
        finalName = finalName..g_frame_size.height
    elseif platform == cc.PLATFORM_OS_MAC then
        finalName = finalName.."_"
        finalName = finalName..1024
        finalName = finalName.."x"
        finalName = finalName..768
    else
    --other
    end
    finalName = finalName..suffix
    return finalName
end

-- 1000000 => 1,000,000
tgFormatNum1 = function(num)
    if nil == num then
        return ""
    end
    local numStr = tostring(num)
    local t = {}
    local ended = #numStr
    while true do
        if ended < 1 then
            break
        end
        local start = ended - 2
        if start < 1 then
            start = 1
        end
        local subStr = string.sub(numStr,start,ended)
        table.insert(t, 1, subStr)
        ended = start-1
    end
    return table.concat(t,",")
end

-- 1000000 => 1000K
tgFormatNum2 = function(num)
--    todogy
end

-- 1000000 => 00:00:00
tgFormatNum3 = function(num)
--    todogy
end






