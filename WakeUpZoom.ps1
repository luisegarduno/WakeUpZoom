$pshost = Get-Host
$pswindow = $pshost.ui.rawui
$newsize = $pswindow.buffersize
$newsize.height = 3000
$newsize.width = 150
$pswindow.buffersize = $newsize
$newsize = $pswindow.windowsize
$newsize.height = 50
$newsize.width = 150
$pswindow.windowsize = $newsize

# ASCII Art
$art = ('
            $$\      $$\           $$\                 $$\   $$\           $$$$$$$$\                                  $$\       
            $$ | $\  $$ |          $$ |                $$ |  $$ |          \____$$  |                                 $$ |
            $$ |$$$\ $$ | $$$$$$\  $$ |  $$\  $$$$$$\  $$ |  $$ | $$$$$$\      $$  / $$$$$$\   $$$$$$\  $$$$$$\$$$$\  $$ |
            $$ $$ $$\$$ | \____$$\ $$ | $$  |$$  __$$\ $$ |  $$ |$$  __$$\    $$  / $$  __$$\ $$  __$$\ $$  _$$  _$$\ $$ |
            $$$$  _$$$$ | $$$$$$$ |$$$$$$  / $$$$$$$$ |$$ |  $$ |$$ /  $$ |  $$  /  $$ /  $$ |$$ /  $$ |$$ / $$ / $$ |\__|
            $$$  / \$$$ |$$  __$$ |$$  _$$<  $$   ____|$$ |  $$ |$$ |  $$ | $$  /   $$ |  $$ |$$ |  $$ |$$ | $$ | $$ |    
            $$  /   \$$ |\$$$$$$$ |$$ | \$$\ \$$$$$$$\ \$$$$$$  |$$$$$$$  |$$$$$$$$\\$$$$$$  |\$$$$$$  |$$ | $$ | $$ |$$\ 
            \__/     \__| \_______|\__|  \__| \_______| \______/ $$  ____/ \________|\______/  \______/ \__| \__| \__|\__|
                                                                 $$ |                                                     
                                                                 $$ |            Website ~ https://garduno.me             
                                                                 \__|                                                     ') 


$TaskDirectory = 'C:\Windows\System32\Tasks\WakeUpZoom'
$boolDirectory = '1'
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

if (-not (Test-Path -LiteralPath $TaskDirectory)) {
    try {
    	$boolDirectory = '0'
        New-Item -Path $TaskDirectory -ItemType Directory -ErrorAction Stop | Out-Null #-Force
    }
    catch {
        Write-Error -Message " ---> Unable to create directory '$TaskDirectory'. Error was: $_ <--- " -ErrorAction Stop
    }
    Write-Host('')
    " ---> Successfully created directory '$TaskDirectory'! Launching WakeUpZoom... <---"
    Start-Sleep -Seconds 2
}

$menu = '0'
while($menu -eq '0' -or $menu -eq '1' -or $menu -eq '2'){
	
	if($menu -eq '0'){
		cls

		# Print title
		Write-Host $art -ForegroundColor "Blue"
		Write-Host('')

		# Print warning
		Write-Host('   Warning: Make sure your Browser opens Zoom Permission to deploy automatically') -ForegroundColor "Red"
		Write-Host('')

		Write-Host('   Main-Menu')
		Write-Host('     > [ 1 ] View/Remove scheduled Zoom call/s')
		Write-Host('     > [ 2 ] Schedule new Zoom Call')
		Write-Host('     > [ 3 ] Exit')
		Write-Host('')
		$menu = Read-Host -Prompt '   > What would you like to do? (1/2/3) '
	}

	while($menu -eq '1'){
		if($boolDirectory -eq '0' -or (Get-ChildItem $TaskDirectory | Measure-Object).Count -eq 0){
			$boolDirectory = '0'
			cls

			# Print title
			Write-Host $art -ForegroundColor "Blue"
			Write-Host('')


			Write-Host(' ---> No Zoom Calls scheduled yet! Returning to Main Menu <---')
			Start-Sleep -Seconds 2

			$menu = '0'
		}
		#if($boolDirectory -eq '1' -and (Get-ChildItem $TaskDirectory | Measure-Object).Count -eq 0) {
 			#$boolDirectory = '0'

 			#cls

			# Print title
			#Write-Host $art -ForegroundColor "Blue"
			#Write-Host('')

 			#Write-Host(' ---> No Zoom Calls scheduled yet! Returning to Main Menu <---')
			#Start-Sleep -Seconds 2

 			#$menu = '0'
		#}
		else{
			cls

			# Print title
			Write-Host $art -ForegroundColor "Blue"
			Write-Host('')

			Write-Host('')
			Write-Host('')
			Get-ScheduledTask -TaskPath "\WakeUpZoom\*"
			Write-Host('--------------------------------------------------------------------------------------')

			Write-Host('')
			Write-Host('     > [ 1 ] View in-depth information')
			Write-Host('     > [ 2 ] Remove a scheduled Zoom call')
			Write-Host('     > [ 3 ] Return to Main-Menu')
			Write-Host('     > [ 4 ] Exit')
			Write-Host('')
			$menu1 = Read-Host -Prompt '   > What would you like to do? (1/2/3/4) '

			if($menu1 -eq '1'){

				cls

				# Print title
				Write-Host $art -ForegroundColor "Blue"
				Write-Host('')

				Write-Host('')
				Write-Host('')
				Get-ScheduledTask -TaskPath "\WakeUpZoom\*" | Get-ScheduledTaskInfo
				Write-Host('--------------------------------------------------------------------------------------')

				Write-Host('')
				Write-Host('     > [ 1 ] Remove a scheduled Zoom call')
				Write-Host('     > [ 2 ] Return to Main-Menu')
				Write-Host('     > [ 3 ] Exit')
				Write-Host('')
				$menu2 = Read-Host -Prompt '   > What would you like to do? (1/2/3) '
				if($menu2 -eq '1') { $menu1 = '2' }
				if($menu2 -eq '2') { $menu = '0' }
				if($menu2 -eq '3') { $menu = '3' }
			}

			if($menu1 -eq '2'){
				$deleteThis = 'y'
				while($deleteThis -eq 'y'){
					cls

					# Print title
					Write-Host $art -ForegroundColor "Blue"
					Write-Host('')

					Write-Host('')
					Write-Host('')
					Get-ScheduledTask -TaskPath "\WakeUpZoom\*"
					Write-Host('--------------------------------------------------------------------------------------')

					Write-Host('')
					$FileToDelete = Read-Host -Prompt '   > Please enter the TaskName (middle column) you wish to delete  '

					# Full Directory of task entered
					$FullDir = $TaskDirectory + '\' + $FileToDelete
					if (Test-Path -Path $FullDir -PathType Leaf) {
     					try {
         					schtasks /delete /tn ('\WakeUpZoom\' + $FileToDelete) /f

							cls

							# Print title
							Write-Host $art -ForegroundColor "Blue"
							Write-Host('')

							Write-Host('')
							Write-Host('')
							Get-ScheduledTask -TaskPath "\WakeUpZoom\*"
							Write-Host('--------------------------------------------------------------------------------------')

							Write-Host('')
         					Write-Host($FileToDelete + ' has been succesfully deleted.') -ForegroundColor "Green"

         					if( (Get-ChildItem $TaskDirectory | Measure-Object).Count -eq 0) {
 								$boolDirectory = '0'

 								Write-Host(' ---> No Zoom Calls scheduled yet! Returning to Main Menu <---')
								Start-Sleep -Seconds 2
 								$menu = '0'
 								$deleteThis = 'n'
							}
							else {
								$deleteThis = Read-Host -Prompt '   > Would you like to delete another course from your schedule? (y/n) '
							}

     					}	
     					catch {
     						throw $_.Exception.Message
     						Start-Sleep -Seconds 2
     					}
 					}
 					else {
 						Write-Host ('Task/Course ' + $FullDir + ' does not exist')
 						Start-Sleep -Seconds 2
 					}
				}

				if ($boolDirectory -eq '0'){
					$menu = '0'
				}
				else{

					cls

					# Print title
					Write-Host $art -ForegroundColor "Blue"
					Write-Host('')

					Write-Host('')
					Write-Host('')
					Get-ScheduledTask -TaskPath "\WakeUpZoom\*"
					Write-Host('--------------------------------------------------------------------------------------')

					Write-Host('')
					Write-Host('     > [ 1 ] View in-depth information')
					Write-Host('     > [ 2 ] Return to Main-Menu')
					Write-Host('     > [ 3 ] Exit')
					Write-Host('')
					$menu2 = Read-Host -Prompt '   > What would you like to do? (1/2/3) '
					if($menu2 -eq '1') { $menu1 = '1' }
					if($menu2 -eq '2') { $menu = '0' }
					if($menu2 -eq '3') { $menu = '3' }
				}
			}

			if($menu1 -eq '3') { $menu = '0' }
			if($menu1 -eq '4') { $menu = '3' }
		}
	}

	if($menu -eq '2'){
		$choice = 'y'

		# Keep the looping until `choice` equals something other than 'y'
		while($choice -eq 'y'){
			cls                                                         # Clear terminal screen
		  	Write-Host $art -ForegroundColor "Blue"                     # Print title

		  	# Print example of input format
		  	Write-Host('')
		  	Write-Host('(NOTE) For Course name, DO NOT use characters like \/:*?"><|', [environment]::newline) -ForegroundColor "DarkRed"
		  	Write-Host('Example of VALID format: ') -ForegroundColor "Green"
		  	Write-Host('Course name ---> : MATH 101 - Calc I') -ForegroundColor "Magenta"
		  	Write-Host('     > URL : https://zoom.us/j/123451231') -ForegroundColor "Magenta"
		  	Write-Host('     > Time : 10:30AM') -ForegroundColor "Magenta"
		  	Write-Host('     > Frequency (Once/Weekly) : Weekly') -ForegroundColor "Magenta"
		  	Write-Host('          > What days? : TTH', [environment]::newline) -ForegroundColor "Magenta"
		  	Write-Host('')

		  	# Ask user to input the necessary information
		  	$name = Read-Host -Prompt 'Course name ---> '               # Course name
		  	$url = Read-Host -Prompt '     > URL '                      # Zoom URL
		  	$clk = Read-Host -Prompt '     > Time '                     # Course start time
		  	$fq = Read-Host -Prompt '     > Frequency (Once/Weekly) '   # Course frequency


		  	$M = 'Monday'; $T = 'Tuesday'; $W = 'Wednesday'; $TH = 'Thursday'; $F = 'Friday'; $freq;

		  	# Create shortcut on Desktop
		  	$WshShell = New-Object -comObject WScript.Shell
		  	$FilePath = "$Home\Desktop\" + $name + ".url"
		  	$Shortcut = $WshShell.CreateShortcut($FilePath)
		  	$Shortcut.TargetPath = $url
		  	$Shortcut.Save()

		  	# Create a new task
		  	# Task action : Execute the created shortcut 
		  	$action = New-ScheduledTaskAction -Execute $FilePath
		  	$freq = ''

		  	# If user select's to use the program once
		  	if($fq -eq 'Once')  {

		    	# Task Trigger : Set the task to trigger once on given time
		    	$trigger = New-ScheduledTaskTrigger -Once -At $clk
		  	}

		  	# If user select's to use the program weekly
		  	if($fq -eq 'Weekly'){
		    	# Prompt user to specify days of week
		    	$freq = Read-Host -Prompt '          > What days?'

		    	# Task Trigger : Set the task to trigger every week depending on the given date & time
		    	if($freq -eq 'M')  { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $M -At $clk }
		    	if($freq -eq 'T')  { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $T -At $clk }
		    	if($freq -eq 'W')  { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $W -At $clk }
		    	if($freq -eq 'TH') { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $TH -At $clk }
		    	if($freq -eq 'F')  { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $F -At $clk }
		    	if($freq -eq 'MW') { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $M,$W -At $clk }
		    	if($freq -eq 'MWF'){ $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $M,$W,$F -At $clk }
		    	if($freq -eq 'TTH'){ $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $T,$TH -At $clk }

		  	}

		  	cls

			# Print title
			Write-Host $art -ForegroundColor "Blue"
			Write-Host('')

			Write-Host('')
			Write-Host('')
			Get-ScheduledTask -TaskPath "\WakeUpZoom\*"
			Write-Host('')

		  	# Finally, register the task
		  	Register-ScheduledTask -TaskName $name -Action $action -Trigger $trigger -TaskPath '\WakeUpZoom'

		  	# Print out the information given
		  	Write-Host('+ ' + $name + ' [' + $url + ' | ' + $clk + ' | ' + $fq + ' - ' + $freq + ']', [environment]::newline) -ForegroundColor "Green"
		  	$freq = '';

		  	$boolDirectory = True

		  	# Ask user if they would like to continue
		  	$choice = Read-Host -Prompt ' --> Would you like to add another course? (y/n) '
		}

		$menu = '0'	
	}
}


# Clear screen when done :)
cls
