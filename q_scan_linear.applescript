tell application id "com.figure53.QLab.5" to tell front workspace
	-- Customizable parameters
	set playDuration to 2 -- Duration in seconds to play each segment
	set skipDuration to 10 -- Duration in seconds to skip forward
	
	-- Get the selected cue
	set selectedCue to first item of (selected as list)
	
	-- Make sure it's an audio cue
	if q type of selectedCue is "Audio" then
		-- Get the total duration once at the start
		set totalDuration to duration of selectedCue
		log "Total track duration: " & totalDuration
		
		-- Set initial parameters
		set start time of selectedCue to 0
		set temp duration of selectedCue to playDuration
		
		repeat
			-- Start playing the segment
			start selectedCue
			
			-- Wait for the segment to finish
			delay (playDuration + 0.1) -- slightly longer than duration to ensure completion
			
			-- Stop the cue
			stop selectedCue
			
			-- Move start time forward
			set currentStart to start time of selectedCue
			set nextStart to (currentStart + skipDuration)
			
			-- Log the positions for debugging
			log "Current position: " & currentStart & ", Next position: " & nextStart & " of " & totalDuration
			
			-- Check if next position would exceed track length
			if nextStart > (totalDuration - playDuration) then
				log "Resetting to start (would exceed track length)"
				set start time of selectedCue to 0
			else
				set start time of selectedCue to nextStart
			end if
		end repeat
	end if
end tell 