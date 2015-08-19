# Bendell Stow - KPMG Data Analytics
# Powershell 101
# Section 3 - Using Pipeline

#### 3 PIPELINE #####################################################################

# | can be used to string commands together

# use get-member, it is your friend
Get-Process # gives a select number of fields
Get-ChildItem 


##### Simple Pipeline
Get-ChildItem | get-Member # gives you additional options available to select 


##### Building up the pipeline with commands (below used on most projects)
Get-ChildItem C:\ps101 -Recurse | Select-Object name, LastAccessTime, LastWriteTime, Directory | Out-File -FilePath C:\ps101\0_Output\testfile.txt 


#### Formatting 
Get-ChildItem | Format-Table | Select-Object name, LastAccessTime # Bad :-( 
# BEWARE OF FORMATTING IN THE PIPELINE!!!!!!!!
Get-ChildItem | Select-Object Name, LastAccessTime, Directory | Format-List # Good :-) 
