param(
    [string] 
    [Parameter(Mandatory = $true)]
    $user,
    [string]
    [Parameter(Mandatory = $true)]
    $pass
)

Clear-Host
$location = Get-Location
Set-Location $PSScriptRoot

docker build -t "test" --build-arg USER=$user --build-arg PASS=$pass .

Set-Location $location