-- trackcontrol.lua
-- Solo and mute specific tracks in REAPER

-- Specify track numbers to solo and mute (1-based index but reaper is 0-based. fixed later with a -1
local tracks_to_solo = {1, 2} -- Example: solo tracks 1 and 2
local tracks_to_mute = {3, 4} -- Example: mute tracks 3 and 4

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