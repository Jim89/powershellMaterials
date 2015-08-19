# Bendell Stow - KPMG Data Analytics
# Powershell 101
# Section 5 - Looping constructs

#### 5 LOOPS ################################################################################################

# simple number loop ########################################################################################
1..10

# more complex loop #########################################################################################
$a = 1..5
$b = 30..35
$c = 100..105
$d = $a + $b + $c 
$d # a concat in this case...

foreach ($i in $d)
{
    Write-Host "old value = $i : new_value = "($i + 5) # notice how easy powershell strings are!!! no escape characters for the likes of you...
}


# using the .NET C# style looping syntax ####################################################################

for($c = 0; $c -le 10; $c++) # be sure to use -le, powershell doesn't like <, <=, >, >=
{
    Write-Host $c
}


# filtering loops with where clauses ########################################################################
$a = 1..100

foreach($i in $a)
{
    If ($i % 8 -eq 0)
    {
        Write-Host $i -BackgroundColor Green
    } 
    else
    {
        Write-Host $i -BackgroundColor DarkGray
    }
}
# note : Add an else construct in here as well


# Do loop ###############################################################################################
$val = 0
Do { $val++ ; Write-Host $val } while($val -ne 10)

$val = 0
Do { 
    $val++
    Write-Host $val 
    } 
while($val -ne 10)



##### A more practical example #################################################################################
# Move all files in a directory and datestanp
$directory = 'C:\ps101\0_Data\loopsData'
$destinationDirectory = 'C:\ps101\0_Data\newFileDestination\'
$today = Get-Date -Format 'yymmdd'

foreach ($file in Get-ChildItem $directory )
{
    Copy-Item $file.FullName -Destination $destinationDirectory$today$file
    Write-Host "Moving : $file    | Destination: $destinationDirectory$today$file"
}


# Another more useful example ##################################################################################
Remove-Item C:\ps101\0_Output\filteredOutput.csv
# scanning a file and outputting selected content

foreach ($line in Get-Content C:\ps101\0_Data\loopsData\DAStaff.csv )
{
    if (( $line -like '*Stow*') -or ($line -like '*Evans*')) # note the double bracket for multiple conditions
    {
        $line | Out-File C:\ps101\0_Output\filteredOutput.csv -Append # you can output so csv, txt, dat if you want
    } 
}



# A practical (slightly more complex...) example ############################################################
# SEPA Analysis work
$file = get-content C:\ps101\0_Data\fileAnnoying3lines.txt
$ctr =  0

foreach($line in $file)
{
$ctr += 1
if ($line[0] -eq '/')
    {
    $file[$ctr - 1], $file[$ctr] , $file[$ctr + 1] -join '|'
    }
} 




