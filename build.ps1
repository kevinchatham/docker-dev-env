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

docker build -t "test" --build-arg USERNAME=$user --build-arg PASSWORD=$pass .

Set-Location $location