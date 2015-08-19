# Bendell Stow - KPMG Data Analytics
# Powershell 101
# Section 7 - Objects and some advanced stuff

#### 8 Put the fun in FUNCTION !!! ################################################################

##### A basic function ############################################################################

function time { Get-Date } 
time

# Putting a little more meat on the function parameter bones...adding types and optionality
function print-something ([Parameter(mandatory=$false)][string]$thingToPrint)
{
    Write-Host $thingToPrint
}

print-something -thingToPrint 'hello there!!'


### with parameters and processes (You need a 'process' if you are supplying parameters in a param block)

function print-somethingElse
{
Param([Parameter(mandatory=$True)][string]$myfirstname,
      [Parameter(mandatory=$False)][string]$mysecondname
        )
process
    {
        #if( $mysecondname -eq $null){ $mysecondname = ''}
        $fullname = $myfirstname, $mysecondname -join ' '
        Write-Host "My name is : $fullname"
    }
}

print-somethingElse -myfirstname 'Bendell'


##### An numeric example with parameters  ############################################################################

function Countdown ([int]$Num1)
{   $a = 1..100
    Write-Host "$Num1 Times tables:"
    foreach($i in $a)
    {
        if(($Num1*$i)-le 1000)
        {
            Write-Host "$Num1 x $i = "($Num1*$i)
        }
    }
}

Countdown '25' 
Countdown -Num1 10


##### A more practical example ############################################################################
# Make a parameter mandatory and make your own pipeline |||||||||||||||||
function concatAll 
{ 
    Param
    ([Parameter(Mandatory=$True, ValueFromPipeLine=$True)][string]$directory,
     [Parameter(Mandatory=$False)][string]$message
     )
    Process
    {
    $list = Get-ChildItem $directory | Select-Object Name, LastAccessTime
    $list
    }
}

concatAll('C:\DA_Powershell') # standard function call
'c:\da_powershell' | concatAll 





##### A complex example, which hopefully isn't too scary anymore... - SQL Server function ######################################################
<# 

SYNOPSIS 		Runs a T-SQL script. 
DESCRIPTION 	Runs a T-SQL script. Invoke-Sqlcmd2 only returns message output, such as the output of PRINT statements when -verbose parameter is specified 
INPUTS 			None -- You cannot pipe objects to Invoke-Sqlcmd2 
OUTPUTS 		System.Data.DataTable 
EXAMPLE 		Invoke-Sqlcmd2 -ServerInstance "MyComputer\MyInstance" -Query "SELECT login_time AS 'StartTime' FROM sysprocesses WHERE spid = 1" 
				This example connects to a named instance of the Database Engine on a computer and runs a basic T-SQL query. 
StartTime 		2010-08-12 21:21:03.593 
EXAMPLE 		Invoke-Sqlcmd2 -ServerInstance "MyComputer\MyInstance" -InputFile "C:\MyFolder\tsqlscript.sql" | Out-File -filePath "C:\MyFolder\tsqlscript.rpt" 
				This example reads a file containing T-SQL statements, runs the file, and writes the output to another file. 
EXAMPLE 		Invoke-Sqlcmd2  -ServerInstance "MyComputer\MyInstance" -Query "PRINT 'hello world'" -Verbose 
				This example uses the PowerShell -Verbose parameter to return the message output of the PRINT command. 
VERBOSE: 		hello world 

#> 
function Invoke-Sqlcmd2 
{ 
    [CmdletBinding()] 
    param( 
    [Parameter(Position=0, Mandatory=$true)] [string]$ServerInstance, 
    [Parameter(Position=1, Mandatory=$false)] [string]$Database, 
    [Parameter(Position=2, Mandatory=$false)] [string]$Query, 
    [Parameter(Position=3, Mandatory=$false)] [string]$Username, 
    [Parameter(Position=4, Mandatory=$false)] [string]$Password, 
    [Parameter(Position=5, Mandatory=$false)] [Int32]$QueryTimeout=600, 
    [Parameter(Position=6, Mandatory=$false)] [Int32]$ConnectionTimeout=15, 
    [Parameter(Position=7, Mandatory=$false)] [ValidateScript({test-path $_})] [string]$InputFile, 
    [Parameter(Position=8, Mandatory=$false)] [ValidateSet("DataSet", "DataTable", "DataRow")] [string]$As="DataRow" 
    ) 
 
    if ($InputFile) 
    { 
        $filePath = $(resolve-path $InputFile).path 
        $Query =  [System.IO.File]::ReadAllText("$filePath") 
    } 
 
    $conn=new-object System.Data.SqlClient.SQLConnection 
      
    if ($Username) 
    { $ConnectionString = "Server={0};Database={1};User ID={2};Password={3};Trusted_Connection=False;Connect Timeout={4}" -f $ServerInstance,$Database,$Username,$Password,$ConnectionTimeout } 
    else 
    { $ConnectionString = "Server={0};Database={1};Integrated Security=True;Connect Timeout={2}" -f $ServerInstance,$Database,$ConnectionTimeout } 
 
    $conn.ConnectionString=$ConnectionString 
     
    #Following EventHandler is used for PRINT and RAISERROR T-SQL statements. Executed when -Verbose parameter specified by caller 
    if ($PSBoundParameters.Verbose) 
    { 
        $conn.FireInfoMessageEventOnUserErrors=$true 
        $handler = [System.Data.SqlClient.SqlInfoMessageEventHandler] {Write-Verbose "$($_)"} 
        $conn.add_InfoMessage($handler) 
    } 
     
    $conn.Open() 
    $cmd=new-object system.Data.SqlClient.SqlCommand($Query,$conn) 
    $cmd.CommandTimeout=$QueryTimeout 
    $ds=New-Object system.Data.DataSet 
    $da=New-Object system.Data.SqlClient.SqlDataAdapter($cmd) 
    [void]$da.fill($ds) 
    $conn.Close() 
    switch ($As) 
    { 
        'DataSet'   { Write-Output ($ds) } 
        'DataTable' { Write-Output ($ds.Tables) } 
        'DataRow'   { Write-Output ($ds.Tables[0]) } 
    } 
 
} #Invoke-Sqlcmd2
