# Clear terminal screen
cls

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

# Print title
Write-Host $art -ForegroundColor "Blue"

# Print warning
Write-Host('Warning: MAKE SURE TO TEST IT BEFORE ACTUALLY USING IT (might need to sign into zoom)') -ForegroundColor "Red"

# Display question and save as `choice`
$choice = Read-Host -Prompt 'Would you like schedule a course? (y/n) '

# Keep the looping until `choice` equals something other than 'y'
while($choice -eq 'y'){
  cls                                                         # Clear terminal screen
  Write-Host $art -ForegroundColor "Blue"                     # Print title

  # Print example of input format
  Write-Host('')
  Write-Host('(NOTE) For Course name, DO NOT use characters like \/:*?"><|', [environment]::newline) -ForegroundColor "DarkRed"
  Write-Host('Example of VALID format: ') -ForegroundColor "Yellow"
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

    $freq = '';
  }

  # Finally, register the task
  Register-ScheduledTask -TaskName $name -Action $action -Trigger $trigger

  # Print out the information given
  Write-Host('+ ' + $name + ' [' + $url + ' | ' + $clk + ' | ' + $freq + ']', [environment]::newline) -ForegroundColor "Green"

  # Ask user if they would like to continue
  $choice = Read-Host -Prompt 'Would you like to add another course? (y/n) '
}

# Clear screen when done :)
cls
