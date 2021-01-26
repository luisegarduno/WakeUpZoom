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

$course = Read-Host -Prompt 'Would you like schedule a course? (y/n) '

while($course -eq 'y'){
  cls
  Write-Host $art -ForegroundColor "Blue"

  $name = Read-Host -Prompt 'Course name ---> '               # Course name
  $url = Read-Host -Prompt '     > URL '                      # Zoom URL
  $clk = Read-Host -Prompt '     > Time '                     # Course start time
  $fq = Read-Host -Prompt '     > Frequency '                 # Course frequency

  # Create shortcut on Desktop
  $WshShell = New-Object -comObject WScript.Shell
  $FilePath = "$Home\Desktop\" + $name + ".url"
  $Shortcut = $WshShell.CreateShortcut($FilePath)
  $Shortcut.TargetPath = $url
  $Shortcut.Save()

  # Create a new task
  # Task action : Execute the created shortcut 
  $action = New-ScheduledTaskAction -Execute $FilePath

  $M = 'Monday'; $T = 'Tuesday'; $W = 'Wednesday'; $TH = 'Thursday'; $F = 'Friday';

  # Task Trigger : Set the task to trigger every week depending on the date & time
  if($fq -eq 'M')  { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $M -At $clk }
  if($fq -eq 'T')  { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $T -At $clk }
  if($fq -eq 'W')  { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $W -At $clk }
  if($fq -eq 'TH') { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $TH -At $clk }
  if($fq -eq 'F')  { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $F -At $clk }
  if($fq -eq 'MW') { $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $M,$W -At $clk }
  if($fq -eq 'MWF'){ $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $M,$W,$F -At $clk }
  if($fq -eq 'TTH'){ $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek $T,$TH -At $clk }

  # Finally, register the task
  Register-ScheduledTask -TaskName $name -Action $action -Trigger $trigger

  Write-Host('+ ' + $name + ' [' + $url + ' | ' + $clk + ' | ' + $freq + ']', [environment]::newline) -ForegroundColor "Green"

  $course = Read-Host -Prompt 'Would you like to add another course? (y/n) '
}

cls
