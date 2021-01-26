# Clear terminal screen
cls

# Print ASCII Art
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

Write-Host $art -ForegroundColor "Blue"

Write-Host('Warning: MAKE SURE TO TEST IT BEFORE ACTUALLY USING IT') -ForegroundColor "Red"

$course = Read-Host -Prompt 'Would you like schedule a course? (y/n) '

while($course -eq 'y'){
  cls
  Write-Host $art -ForegroundColor "Blue"

  Write-Host('')
  Write-Host('Example of format: ') -ForegroundColor "DarkRed"
  Write-Host('Course name ---> : Calc II') -ForegroundColor "Magenta"
  Write-Host('     > URL : https://zoom.us/j/123451231') -ForegroundColor "Magenta"
  Write-Host('     > Time : 10:30AM') -ForegroundColor "Magenta"
  Write-Host('     > Frequency (Once/Weekly) : Weekly') -ForegroundColor "Magenta"
  Write-Host('          > What days? : TTH', [environment]::newline) -ForegroundColor "Magenta"
  Write-Host('')

  $name = Read-Host -Prompt 'Course name ---> '               # Course name
  $url = Read-Host -Prompt '     > URL '                      # Zoom URL
  $clk = Read-Host -Prompt '     > Time '                     # Course start time
  $fq = Read-Host -Prompt '     > Frequency (Once/Weekly) '   # Course frequency
  $M = 'Monday'; $T = 'Tuesday'; $W = 'Wednesday'; $TH = 'Thursday'; $F = 'Friday';

  # Create shortcut on Desktop
  $WshShell = New-Object -comObject WScript.Shell
  $FilePath = "$Home\Desktop\" + $name + ".url"
  $Shortcut = $WshShell.CreateShortcut($FilePath)
  $Shortcut.TargetPath = $url
  $Shortcut.Save()

  # Create a new task
  # Task action : Execute the created shortcut 
  $action = New-ScheduledTaskAction -Execute $FilePath

  $freq;
  if($fq -eq 'Once')  {

    # Task Trigger : Set the task to trigger on given time
    $trigger = New-ScheduledTaskTrigger -Once -At $clk
  }

  if($fq -eq 'Weekly'){
    $freq = Read-Host -Prompt '          > What days?'

    # Task Trigger : Set the task to trigger every week depending on the date & time
    if($freq -eq 'M')  { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $M -At $clk }
    if($freq -eq 'T')  { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $T -At $clk }
    if($freq -eq 'W')  { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $W -At $clk }
    if($freq -eq 'TH') { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $TH -At $clk }
    if($freq -eq 'F')  { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $F -At $clk }
    if($freq -eq 'MW') { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $M,$W -At $clk }
    if($freq -eq 'MWF'){ $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $M,$W,$F -At $clk }
    if($freq -eq 'TTH'){ $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $T,$TH -At $clk }
  }

  # Finally, register the task
  Register-ScheduledTask -TaskName $name -Action $action -Trigger $trigger


  Write-Host('+ ' + $name + ' [' + $url + ' | ' + $clk + ' | ' + $freq + ']', [environment]::newline) -ForegroundColor "Green"

  $course = Read-Host -Prompt 'Would you like to add another course? (y/n) '
}

cls
