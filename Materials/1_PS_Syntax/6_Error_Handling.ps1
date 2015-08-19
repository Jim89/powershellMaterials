# Bendell Stow - KPMG Data Analytics
# Powershell 101
# Section 6 - Error Handling

#### 6 ERROR HANDLING #################################################################

# Catch and handle errors in your scripting
# Similar concept syntactically to SQL Server, C#, Python etc...

##### A simple example ################################################################

1 / 0


# ?. A good time to start using code snippeting ( ctrl+j )
# 1. Try = have a go at doing xyz action
# 2. Catch = if this fails do a different action
# 3. Finally = At the end of your process do something else (optional)

##### An example ######################################################################

$a = 0
$b = 1

try{    
        $b / $a
        Write-Host "this has worked!" -BackgroundColor Green
    }

catch{
        Write-Host "this does not work, stupid" -BackgroundColor Red 
        $d = Get-Date
        "Error", $d, 'MESSAGE: I have made a big daft error' -join ' | ' | Out-File -FilePath C:\ps101\0_Data\myresultfile.txt
    }

finally{
        Write-Host "end of error handling example" -BackgroundColor Blue
    }

#######################################################################################
# A slightly more practical example - Opening a file which doesn't exist ##############

try  {
        $x = Get-Content C:\ps101\0_Data\MyMadeUpFile.txt -ErrorAction Stop
        $x[1]
      }
catch{
        Write-Host "failed opening file" -BackgroundColor Red
      }

# Under the hood ######################################################################

# Current error preference variable
$ErrorActionPreference 

# Error logs under the hood
$Error 
$Error | gm
$Error[0]
$Error.Clear()

Get-Help about_Try_Catch_Finally 