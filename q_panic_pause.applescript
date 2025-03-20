tell application id "com.figure53.QLab.5" to tell front workspace
	-- Get all currently running cues
	set runningCues to active cues
	
	-- Iterate through each running cue
	repeat with currentCue in runningCues
		-- Get the cue type
		set cueType to q type of currentCue
		
		-- Handle script cues differently
		if cueType is "Script" then
			-- Panic just the script cue
			panic currentCue
		else
			-- Pause all other types of cues
			pause currentCue
		end if
	end repeat
end tell 