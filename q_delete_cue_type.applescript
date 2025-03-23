tell application id "com.figure53.QLab.5" to tell front workspace
	-- Customizable parameter - change this to delete different types of cues
	-- Valid types include: "Audio", "Video", "MIDI", "Script", "Light", "Network", etc.
	set cueTypeToDelete to "Network"
	
	-- Get all cues in the workspace
	set allCues to cues
	
	-- Keep track of how many cues we delete
	set deletedCount to 0
	
	-- Iterate through each cue
	repeat with currentCue in allCues
		-- Check if it's the type we want to delete
		if q type of currentCue is cueTypeToDelete then
			-- Log what we're about to delete
			log "Deleting cue: " & (q name of currentCue) & " (number: " & (q number of currentCue) & ")"
			
			-- Delete the cue
			delete currentCue
			
			-- Increment our counter
			set deletedCount to deletedCount + 1
		end if
	end repeat
	
	-- Log the final count
	log "Deleted " & deletedCount & " " & cueTypeToDelete & " cues"
end tell 