# Bendell Stow - KPMG Data Analytics
# Powershell 101
# Section 4 - Working with Files and folders

#### 4.1 FOLDERS #####################################################################

Get-ChildItem # details the content of a directory
# ls, gci, dir # the command has several 'aliases' which 
Get-ChildItem -Recurse # (-r)

get-ChildItem | get-member # gives you additional options

# either navigate to the directory directly, or fully justify the path
get-ChildItem C:\ps101\0_Data 
# is equivalent to...
Set-Location C:\ps101\0_Data
Get-ChildItem

cd /

Get-ChildItem # is equivalent to
$myLocation = 'C:\ps101\0_Data'
Get-ChildItem $myLocation

# filter to file types
Get-ChildItem C:\ps101\0_Data *.ppt

# inlude allows multiple filters
Get-ChildItem C:\ps101\0_Data\* -Include *.txt, *.pptx

# can use the pipeline for matching with the 'Where-Object' cmd-let
Get-ChildItem C:\ps101\0_Data\ | Where-Object name -Match '.csv'

# support for regular expressions
Get-ChildItem C:\ps101\0_Data\ | Select-Object Name | Where-Object name -Match '^[0-9]{8,10}' 


#### 4.2 Files #######################################################################

# Load and display a file
Get-Content C:\ps101\0_Data\loopsData\DAStaff.csv

# Write this to a variable 
$myfile = Get-Content C:\ps101\0_Data\loopsData\DAStaff.csv
$myfile[0]

# Output to a file (more complex examples later)
$myfile[0] | Out-File -FilePath C:\ps101\0_Output\myFirstOutputFile.txt  # you can append here if you want

# Concatenate lots of files 
### real world example - Used recently on Nougat 
$dir = "C:\ps101\0_Data\concat\Loadsofscripts"
$resultfile = "C:\ps101\0_Output\allmyscripts.sql"

if ((Test-Path $resultfile) -eq $true) # curly braces
{
    Remove-Item $resultfile
}

foreach ($file in Get-ChildItem $dir) 
{
	get-content $file.FullName | out-file $resultfile -append  # fullname method used...

}

# What was that test-path doing....?
Test-Path $resultfile


# You can input/output to a variety of formats
# Dealing with XML in the shell
get-content C:\ps101\0_Data\TestXMLfile.xml

$myxml = [xml](get-content C:\ps101\0_Data\TestXMLfile.xml)
$myxml.CATALOG 
# feel free to use a get member if you get stuck!!!

$myxml.CATALOG.CD
$myxml.CATALOG.CD | Format-Table 
$myxml.CATALOG.CD | Format-Table | Out-File -FilePath C:\ps101\0_Output\xmltoCsv.csv

# You can input/output to a variety of formats
$myxml.CATALOG.CD | ConvertTo-Csv 
$myxml.CATALOG.CD | Select-Object ARTIST, YEAR, COMPANY | ConvertTo-Html | Out-File -FilePath C:\ps101\0_Output\outputasHTML.html 
