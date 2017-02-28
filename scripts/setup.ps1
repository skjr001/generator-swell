
function installChoclatey()
{
    try 
    {
        Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression
    } 
    catch 
    {
        Write-Error "Failed to install chocolatey"
    }
}

if (!$IsWindows)
{
    "Not using windows, invoking shell script"
    Set-Location $PSScriptRoot
    /bin/bash ./unix-setup.sh
}
else 
{
    "Not implimented yet"    
}