require "AudioEngine" 
MUSIC_BACK ={nom="music/background.mp3",game="music/background.mp3"}
local LINE_SPACE = 40
name=nil
function playBackMusic(_name,_bool)
    -- body
    if name~=_name then 
    name=_name 
    AudioEngine.stopMusic()
    AudioEngine.playMusic(_name, _bool)
    end 
end
function stopBackMusic()
    -- body
    AudioEngine.stopMusic()
    name=nil
end
function Backpause( )
    -- body
    AudioEngine.pauseMusic()
end
function Backresume( )
    -- body
    AudioEngine.resumeMusic()
end
