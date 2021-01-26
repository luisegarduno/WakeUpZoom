# Create a task

# Store the current working directory
# $current_directory = Get-Location | select -ExpandProperty Path

# Store 'course.yer' as variable
# $file_data = Get-Content course.yer

# Clear terminal screen
cls

Write-Host('
            $$\      $$\           $$\                 $$\   $$\           $$$$$$$$\                                  $$\ 
            $$ | $\  $$ |          $$ |                $$ |  $$ |          \____$$  |                                 $$ |
            $$ |$$$\ $$ | $$$$$$\  $$ |  $$\  $$$$$$\  $$ |  $$ | $$$$$$\      $$  / $$$$$$\   $$$$$$\  $$$$$$\$$$$\  $$ |
            $$ $$ $$\$$ | \____$$\ $$ | $$  |$$  __$$\ $$ |  $$ |$$  __$$\    $$  / $$  __$$\ $$  __$$\ $$  _$$  _$$\ $$ |
            $$$$  _$$$$ | $$$$$$$ |$$$$$$  / $$$$$$$$ |$$ |  $$ |$$ /  $$ |  $$  /  $$ /  $$ |$$ /  $$ |$$ / $$ / $$ |\__|
            $$$  / \$$$ |$$  __$$ |$$  _$$<  $$   ____|$$ |  $$ |$$ |  $$ | $$  /   $$ |  $$ |$$ |  $$ |$$ | $$ | $$ |    
            $$  /   \$$ |\$$$$$$$ |$$ | \$$\ \$$$$$$$\ \$$$$$$  |$$$$$$$  |$$$$$$$$\\$$$$$$  |\$$$$$$  |$$ | $$ | $$ |$$\ 
            \__/     \__| \_______|\__|  \__| \_______| \______/ $$  ____/ \________|\______/  \______/ \__| \__| \__|\__|
                                                                 $$ |                                                     
                                                                 $$ |                                                     
                                                                 \__|                                                     ') -ForegroundColor "Blue"

$course = Read-Host -Prompt 'Would you like schedule a course? (y/n) '

while($course -eq 'y'){
  # Course Name
  $crs = Read-Host -Prompt 'Course name ---> ' 

  # Zoom URL
  $url = Read-Host -Prompt '     > URL '
  # Course start time
  $clk = Read-Host -Prompt '     > Time '
  # Course frequency 
  $freq = Read-Host -Prompt '     > Frequency '
  Write-Host('+ [' + $url + ' | ' + $clk + ' | ' + $freq + ']', [environment]::newline) -ForegroundColor "Green"

  $course = Read-Host -Prompt 'Would you like to add another course? (y/n) '
}

