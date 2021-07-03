$Folder_Youre_Scanning_Into = "Enter a folder here like C:\Input"
$Organized_Folder = "Enter a folder here like C:\Output"
Get-ChildItem $Folder_Youre_Scanning_Into |  #This grabs every file from the folder you're scanning into and sends it to the function below
ForEach-Object{ #The function for every function sent, crops out a Date, then a year and month from that
    $Date = $_.Name -replace "[^\d+^-]" #This sets the date to $_.Name which is the name of the file, and replaces with a space everything thats not(^) a digit(\d) or a dash (-)
    $Year = [regex]::Match($Date,'\d\d\d\d').Value # finds 4 digits in a row, which could only be the year
    $Month = [regex]::Match($Date,'-\d\d-').Value # finds text in the Date thats a dash followed by 2 digits then another dash
    $Month = $Month -replace "-" # replaces the dash with a space
    $Folder = "$Organized_Folder\$Year-$Month" # This is the path to folder these would be put in
    if (Test-Path -Path $Folder) { #if the folder exists already
        Move-Item -Path $_.FullName -Destination $Folder #Move the file there
    } else {
        New-Item -Path $Folder -ItemType Directory #if not make a new folder (Directory) and move it there
        Move-Item -Path $_.FullName -Destination $Folder
    }
}
## Currently this is written in Year/Month/Day format