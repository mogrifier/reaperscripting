-- trackcontrol.lua
-- Solo and mute specific tracks in REAPER

--reset all tracks to unsoloed and unmuted
local num_tracks = reaper.CountTracks(0)
for i = 1, num_tracks - 1 do
  local track = reaper.GetTrack(0, i)
  if track then
    reaper.SetMediaTrackInfo_Value(track, "I_SOLO", 0)  -- unsolo track
    reaper.SetMediaTrackInfo_Value(track, "B_MUTE", 0)  -- unmute track
  end
end
reaper.UpdateArrange()

--now based on the midi cc message received, solo or mute specific tracks
-- Specify track numbers to solo and mute (1-based index but reaper is 0-based. fixed later with a -1
local tracks_to_solo = {5} -- Example: solo tracks 1 and 2
local tracks_to_mute = {2} -- Example: mute tracks 3 and 4

-- Get the number of tracks in the project
local num_tracks = reaper.CountTracks(0)

-- Solo specified tracks
for _, track_idx in ipairs(tracks_to_solo) do
    if track_idx <= num_tracks then
        local track = reaper.GetTrack(0, track_idx - 1)
        reaper.SetMediaTrackInfo_Value(track, "I_SOLO", 1)
    end
end

-- Mute specified tracks
for _, track_idx in ipairs(tracks_to_mute) do
    if track_idx <= num_tracks then
        local track = reaper.GetTrack(0, track_idx - 1)
        reaper.SetMediaTrackInfo_Value(track, "B_MUTE", 1)
    end
end

reaper.UpdateArrange()