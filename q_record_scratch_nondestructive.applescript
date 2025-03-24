tell application id "com.figure53.QLab.5" to tell front workspace
    --Set time variable
    set loopDuration to 1
	-- Get the selected cue
	set selectedCue to first item of (selected as list)
	
	-- Make sure it's an audio or video cue and it's running
	if (q type of selectedCue is "Audio" or q type of selectedCue is "Video") and running of selectedCue then
		-- Get current position using multiple methods for verification
		set elapsedTime to action elapsed of selectedCue
		
		-- Use elapsed time as our primary source
		set currentPosition to elapsedTime
		
		-- Calculate the loop start point
		set loopStart to (currentPosition - loopDuration)
		if loopStart < 0 then
			set loopStart to 0
		end if
		
		-- Set up for looping
		set temp duration of selectedCue to loopDuration -- Play x seconds at a time
		
		-- Initial load to correct position
		hardStop selectedCue
        delay 0.01
		load (selectedCue) time loopStart
        delay 0.01
		
		repeat
			start selectedCue
			delay (loopDuration + 0.01) -- Just enough extra time to prevent skipping
			stop selectedCue
			
			-- Ensure we're still at the right position
			delay 0.01
			load (selectedCue) time loopStart
			delay 0.01
		end repeat
	else
		log "Selected cue must be a running Audio or Video cue"
	end if
end tell 