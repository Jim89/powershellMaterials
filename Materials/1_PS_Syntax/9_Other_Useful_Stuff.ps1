# Bendell Stow - KPMG Data Analytics
# Powershell 101
# Section 9 - Miscellaneous

##### Transcripts ############################################################################
Start-Transcript
Start-Transcript -Path C:\ps101\0_Output\transcript.txt

Write-Host "look at me, this is a transcript"
Get-ChildItem | Get-Member

Stop-Transcript




##### Time objects  ##########################################################################
New-TimeSpan

New-TimeSpan $(get-date) $(Get-Date -Month 8 -Date 15 -Year 1984 -Minute 30 -Hour 12)

# Did you know...you can send emails or download webfiles with powershell...well you can....


## Last but not least...your profile ########################################################

$profile

notepad.exe $profile

New-Item –Path $Profile –Type File –Force


