tell application id "com.figure53.QLab.5" to tell front workspace
	-- Customizable parameters
	set playDuration to 2 -- Duration in seconds to play each segment
	
	-- Get the selected cue
	set selectedCue to first item of (selected as list)
	
	-- Make sure it's an audio cue
	if q type of selectedCue is "Audio" then
		-- Get the total duration once at the start
		set totalDuration to duration of selectedCue
		log "Total track duration: " & totalDuration
		
		-- Set initial parameters
		set temp duration of selectedCue to playDuration
		
		repeat
			-- Generate random position within track length
			-- Subtract playDuration to ensure we don't start too close to the end
			set randomPosition to (random number from 0 to (totalDuration - playDuration))
			set start time of selectedCue to randomPosition
			
			-- Log the position for debugging
			log "Jumping to position: " & randomPosition & " of " & totalDuration
			
			-- Start playing the segment
			start selectedCue
			
			-- Wait for the segment to finish
			delay (playDuration + 0.1) -- slightly longer than duration to ensure completion
			
			-- Stop the cue
			stop selectedCue
		end repeat
	end if
end tell 