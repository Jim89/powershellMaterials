# Bendell Stow - KPMG Data Analytics
# Powershell 101
# Section 0 - Basic Command Syntax

#### SECTION 0 #######################################################################


# = comment block
<# = Long comment block.  Terminated by - #> Write-Host this is outside the comment block...obviously! Notice...I don''''t need quotations



##### Commands #######################################################################
# First specify the name of the command, then the thing you are doing the command on
verb-noun = command "cmd-let"
# For example 
write-host 



##### parameters #####################################################################
# Each command has lots of parameters to control/customise its behaviour
- = parameter 
# for example
write-host "hello world" -BackgroundColor Green 



##### Pipeline #######################################################################
# pass the output of one command to the next
| = Pipeline 
# for example 
get-process | out-file -FilePath C:\ps101\Testing.csv 



#### Variables #######################################################################
# You can assign variables for use in commands
$ = variable assignment
# for example
$a = 10000
$a + 100 
101

# built in variables can be used in scripts (there are lots more)
$true
$false
$Error
$null
$env:USERNAME
$env:OS
$env:COMPUTERNAME
$env:APPDATA
get-date -Format 'yy-MM-dd | HH:mm:ss' # some variables are more useful than others...



#### strings #########################################################################
variables can be embedded in strings without 'escapes'
# A bad example 
$your_variable = " string 2 "
Write-Host "string 1" + $your_variable + "string3"

# A better example
$a = 121
Write-Host "KPMG is $a years old" # uses the $a variable
Write-Host "KPMG is $b years old" # no variable here...so nothing included as $b




#### commands  #######################################################################
#### Simple commands 

#Moving around the filesystem

set-location # cd
get-childitem # gci, dir, ls
get-process # gp

#### More useful commands
# Doing stuff with files
out-file
get-content
export-csv
new-object
copy-item
move-item

#### Getting help
# When you aren't quite sure whats going on
Get-Help # A good start for help...
Get-Alias # when you don't know what something is called!
