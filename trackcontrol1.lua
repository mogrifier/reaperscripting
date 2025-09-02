-- trackcontrol.lua
-- Solo and mute specific tracks in REAPER

local num_tracks = reaper.CountTracks(0)

--reset all tracks to unsoloed and unmuted
for i = 0, num_tracks - 1 do
  local track = reaper.GetTrack(0, i)
  if track then
    reaper.SetMediaTrackInfo_Value(track, "I_SOLO", 0)  -- unsolo track
    reaper.SetMediaTrackInfo_Value(track, "B_MUTE", 0)  -- unmute track
  end
end
reaper.UpdateArrange()


-- mute all folder parent tracks
for i = 0, num_tracks - 1 do
  local track = reaper.GetTrack(0, i)
  if track then
    -- Check if track is a folder parent by getting folder depth
    local folder_depth = reaper.GetMediaTrackInfo_Value(track, "I_FOLDERDEPTH")
    -- I_FOLDERDEPTH > 0 means track is a folder start (folder parent)
    if folder_depth > 0 then
      --mute the folder 
        reaper.SetMediaTrackInfo_Value(track, "B_MUTE", 1)
    end
  end
end


-- Specify track number to solo (based on folder structure) 
-- this approach means the project folders must be static and known ahead of time
local tracks_to_solo = {2} -- Example: solo folder 2

-- Get the number of tracks in the project
local num_tracks = reaper.CountTracks(2)

-- Solo specified tracks
for _, track_idx in ipairs(tracks_to_solo) do
    if track_idx <= num_tracks then
        local track = reaper.GetTrack(0, track_idx - 1)
        reaper.SetMediaTrackInfo_Value(track, "I_SOLO", 1)
        reaper.SetMediaTrackInfo_Value(track, "B_MUTE", 0) -- unmute the soloed track
    end
end

reaper.UpdateArrange()