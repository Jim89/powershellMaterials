# Bendell Stow - KPMG Data Analytics
# Powershell 101
# Section 7 - Objects and some advanced stuff

#### 7 OBJECTS AND BEYOND #####################################################################

##### .NET objects ############################################################################

# A simple example
$pi = [math]::PI
$pi
[math]::Round($pi, 3) # note the double colon ::

# A slightly more useful example (slightly...)
$myfile = 'C:\ps101\0_Data\DotNetLongFile.dat'
[System.IO.Path]::GetFileNameWithoutExtension($myfile)
[System.IO.Path]::GetFullPath($myfile)
[System.IO.Path]::GetExtension($myfile)


# A more useful example - a little help for when get-content is not your friend...
$largefile = 'C:\ps101\0_Data\DotNetLongFile.dat'
$reallylargefile = 'C:\ps101\0_Data\DotNetReallyLongFile.dat'
[System.IO.File]::ReadLines($largefile) # probably not too useful on its own... :-(

$ctr = 0
foreach ($line in [System.IO.File]::ReadLines($reallylargefile)) # this buffers the file a line at a time into the memory, rather than all in one go
{
    $ctr++
}
Write-Host "This file has : $ctr lines"


# An even more useful example - Run a checksum on flat files - build it up line by line
# 1. Step one, have a look at the files
Get-Content $largefile | select -First 1
$lineone = Get-Content $largefile | select -First 1
$lineone

# 2. Process a line, split it to its composite parts
$lineone.Split('::')[2] # notice the [2] here...what is it doing? Similar to R/Python...starts a 1, not 0
$splitline = $lineone.Split('::')
$splitline
$splitline[0]

# 3. Put it altogether. Make a running checksum for a column within the delimited file
$ctr = 0
$checksum = 0
foreach ($line in [System.IO.File]::ReadLines($largefile))
{
    $checksum += $line.Split('::')[1]
}
$checksum




##### Interaction with SQL server ###########################################################

    # Connect and run a command using SQL Native Client, Returns a recordset
    $InstanceName = "UKPK1LZ57\SQLEXPRESS"
    $DatabaseName = "psdb"
    $TableName    = "psTest"

    # Create and open a database connection
    $sqlConnection = new-object System.Data.SqlClient.SqlConnection "server=$InstanceName;database=$DatabaseName;Integrated Security=sspi"
    $sqlConnection.Open()

    #Create a command object
    $sqlCommand = $sqlConnection.CreateCommand()
    $sqlCommand.CommandText = "select * from dbo.$TableName"

    #Execute the Command
    $sqlReader = $sqlCommand.ExecuteReader()

    #Parse the records

    while ($sqlReader.Read()) { $sqlReader["ID"], $sqlReader["Author"], $sqlReader["Timestamp"], $sqlReader["Department"], $sqlReader["Message"] -join ' , ' <#| Out-File C:\data\DBextract.csv -Append #> } 

    # Close the database connection
    $sqlConnection.Close()


##### Interaction with Excel ###########################################################
# An approximation of a real world example - get some data out of a spreadsheet. 
$file = 'C:\ps101\0_Data\excel\myExcelfile.xlsx'
$Excel = New-Object -ComObject excel.application 
$Excel.visible = $false
$Workbook = $excel.Workbooks.open($file) 
$Worksheet = $Workbook.WorkSheets.item("Sheet1") 
$worksheet.activate()  
$cell1 = $WorkSheet.Range("A1").Text
$cell2 = $WorkSheet.Range("A2").Text
"{0},{1}" -f $cell1, $cell2

# Tidy up...close all connections 
$workbook.Close($false)
$Excel.Quit()
Remove-Variable -Name excel 
[gc]::collect() 
[gc]::WaitForPendingFinalizers() 
