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

  $crs = Read-Host -Prompt 'Course name ---> '                # Course name
  $url = Read-Host -Prompt '     > URL '                      # Zoom URL
  $clk = Read-Host -Prompt '     > Time '                     # Course start time
  $freq = Read-Host -Prompt '     > Frequency '               # Course frequency

  # Create shortcut on Desktop
  $WshShell = New-Object -comObject WScript.Shell
  $FilePath = "$Home\Desktop\" + $crs + ".url"
  $Shortcut = $WshShell.CreateShortcut($FilePath)
  $Shortcut.TargetPath = $url
  $Shortcut.Save()

  # Create a new task (docs.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtasktrigger)
  # Task name : same as the course name
  $taskName = $crs        
  # Task action : Execute the created shortcut 
  $taskAction = New-ScheduledTaskAction -Execute $FilePath
  # Task Trigger : Set the task to trigger every week depending on the date & time
  $taskTrigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday Tuesday -At $clk

  # Finally, register the task
  Register-ScheduledTask `
    -TaskName $taskName `
    -Action $taskAction `
    -Trigger $taskTrigger `

  Write-Host('+ ' + $crs + ' [' + $url + ' | ' + $clk + ' | ' + $freq + ']', [environment]::newline) -ForegroundColor "Green"

  $course = Read-Host -Prompt 'Would you like to add another course? (y/n) '
}

cls
