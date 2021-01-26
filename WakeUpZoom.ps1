# Create a task

# Store the current working directory
# $current_directory = Get-Location | select -ExpandProperty Path

# Store 'course.yer' as variable
# $file_data = Get-Content course.yer

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

  $crs = Read-Host -Prompt 'Course name ---> '    # Course name
  $url = Read-Host -Prompt '     > URL '          # Zoom URL
  $clk = Read-Host -Prompt '     > Time '         # Course start time
  $freq = Read-Host -Prompt '     > Frequency '   # Course frequency

  Write-Host('+ ' + $crs + ' [' + $url + ' | ' + $clk + ' | ' + $freq + ']', [environment]::newline) -ForegroundColor "Green"

  $course = Read-Host -Prompt 'Would you like to add another course? (y/n) '
}

cls

