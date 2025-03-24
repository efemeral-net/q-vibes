tell application id "com.figure53.QLab.5" to tell front workspace
	-- Get the selected cue
	set selectedCue to first item of (selected as list)
	
	-- Make sure it's an audio cue and it's running
	if q type of selectedCue is "Audio" and running of selectedCue then
		-- Get the current playback position, accounting for cue's start time
		set cueStartTime to start time of selectedCue
		set currentPosition to cueStartTime + (action elapsed of selectedCue)
		
		-- Calculate the start point (1 second before current position)
		set loopStart to (currentPosition - 1)
		if loopStart < cueStartTime then
			set loopStart to cueStartTime
		end if
		
		-- Stop playback temporarily
		stop selectedCue
		
		-- Set up the loop points
		set start time of selectedCue to loopStart
		set end time of selectedCue to currentPosition
		set infinite loop of selectedCue to true
		
		-- Restart playback
		start selectedCue
		
		-- Log for debugging
		log "Record scratch effect:"
		log "Loop from " & loopStart & " to " & currentPosition
	else
		log "Selected cue must be a running Audio cue"
	end if
end tell 